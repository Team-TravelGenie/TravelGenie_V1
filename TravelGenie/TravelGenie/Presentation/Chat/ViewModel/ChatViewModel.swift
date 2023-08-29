//
//  ChatViewModel.swift
//  TravelGenie
//
//  Created by 서현웅 on 2023/08/15.
//

import UIKit

protocol MessageStorageDelegate: AnyObject {
    func insert(message: Message)
}

protocol ButtonStateDelegate: AnyObject {
    func setUploadButtonState(_ isEnabled: Bool)
}

final class ChatViewModel {
    
    weak var coordinator: ChatCoordinator?
    weak var delegate: MessageStorageDelegate?
    weak var buttonStateDelegate: ButtonStateDelegate?
    var didTapImageUploadButton: (() -> Void)?
    
    private let googleVisionUseCase: GoogleVisionUseCase
    private let user: Sender = Sender(name: .user)
    
    // MARK: Lifecycle
    
    init(googleVisionUseCase: GoogleVisionUseCase) {
        self.googleVisionUseCase = googleVisionUseCase
        registerNotificationObservers()
    }
    
    // MARK: Internal
    
    func insertMessage(_ message: Message) {
        delegate?.insert(message: message)
    }
    
    func makePhotoMessages(_ images: [UIImage]) {
        let totalPhotosToUpload = images.count
        var photoUploadCount = 0
        
        images.forEach {
            let photoMesage = Message(
                image: $0,
                sender: user,
                sentDate: Date())
            
            delegate?.insert(message: photoMesage)
            photoUploadCount += 1
            
            if totalPhotosToUpload == photoUploadCount {
                buttonStateDelegate?.setUploadButtonState(false)
            }
        }
    }
    
    func backButtonTapped() -> (viewModel: PopUpViewModel, type: PopUpContentView.PopUpType) {
        let popUpViewModel = createPopUpViewModel()
        let popUpModel = createPopUpModel()
        
        return (viewModel: popUpViewModel, type: .normal(popUpModel))
    }
    
    func pop() {
        coordinator?.finish()
    }
    
    // MARK: Private
    
    private func requestRecommendations(with tags: [Tag]) {
        let keywords: [String] = tags.map { $0.value }
        // TODO: - ChatGPT에 keyword 넣어서 요청 보내기
    }
    
    private func createPopUpViewModel() -> PopUpViewModel {
        return PopUpViewModel()
    }
    
    private func createPopUpModel() -> PopUpModel {
        let mainText = NSMutableAttributedString()
            .text("대화를 종료하시겠습니까?\n", font: .bodyRegular, color: .black)
            .text("종료하시면 이 대화는 ", font: .bodyRegular, color: .black)
            .text("자동으로 종료", font: .bodyBold, color: .primary)
            .text("되니 주의 부탁 드려요!", font: .bodyRegular, color: .black)
        let leftButtonTitle = NSMutableAttributedString()
            .text("네", font: .bodyRegular, color: .white)
        let rightButtonTitle = NSMutableAttributedString()
            .text("아니요", font: .bodyRegular, color: .black)
        
        return PopUpModel(
            mainText: mainText,
            leftButtonTitle: leftButtonTitle,
            rightButtonTitle: rightButtonTitle)
    }
    
    private func registerNotificationObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didTapImageUploadButton(notification:)),
            name: .imageUploadButtonTapped,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(submitSelectedTags(notification:)),
            name: .tagSubmitButtonTapped,
            object: nil)
    }
    
    // MARK: objc methods
    
    @objc private func didTapImageUploadButton(notification: Notification) {
        didTapImageUploadButton?()
    }

    @objc private func submitSelectedTags(notification: Notification) {
        guard let selectedTags = notification.userInfo?[NotificationKey.selectedTags] as? [Tag] else { return }
        requestRecommendations(with: selectedTags)
    }
}
