//
//  ChatInterfaceViewModel.swift
//  TravelGenie
//
//  Created by summercat on 2023/08/28.
//

final class ChatInterfaceViewModel {
    
    let messageStorage: MessageStorage = MessageStorage()
    var didChangeMessageList: (() -> Void)?
    var didChangeUploadButtonState: ((Bool) -> Void)?
    var didChangeTagCellInteractionStates: (() -> Void)?
    
    private (set) var uploadButtonState: Bool = true {
        didSet {
            didChangeUploadButtonState?(uploadButtonState)
        }
    }
    
    private (set) var tagCellInteractionStates = (submitButtonState: false, interaction: true) {
        didSet {
            didChangeTagCellInteractionStates?()
        }
    }
    
    // MARK: Lifecycle
    
    init() {
        bind()
    }
    
    // MARK: Private
    
    private func bind() {
        messageStorage.didChangeMessageList = { [weak self] in
            self?.didChangeMessageList?()
        }
    }
}

// MARK: MessageStorageDelegate

extension ChatInterfaceViewModel: MessageStorageDelegate {
    func insert(message: Message) {
        messageStorage.insertMessage(message)
    }
    
    func fetchMessages() -> [Message] {
        return messageStorage.fetchMessages()
    }

    func updateTagMessage(tagMessage: Message) {
        messageStorage.updateTagMessage(tagMessage)
    }
}

// MARK: ButtonStateDelegate

extension ChatInterfaceViewModel: ButtonStateDelegate {
    
    func setUploadButtonState(_ isEnabled: Bool) {
        uploadButtonState = isEnabled
    }
    
    func setTagCellButtonState(submitButtonState: Bool, interactionState: Bool) {
        tagCellInteractionStates = (submitButtonState, interactionState)
    }
}
