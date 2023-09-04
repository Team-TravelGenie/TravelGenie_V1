//
//  ChatHistoryCoordinator.swift
//  TravelGenie
//
//  Created by 서현웅 on 2023/09/04.
//

import UIKit

final class ChatHistoryCoordinator: Coordinator {
    
    var finishDelegate: CoordinationFinishDelegate?
    var navigationController: UINavigationController?
    var childCoordinators: [Coordinator] = []
    
    // MARK: Lifecycle
    
    init(finishDelegate: CoordinationFinishDelegate, navigationController: UINavigationController?) {
        self.finishDelegate = finishDelegate
        self.navigationController = navigationController
    }
    
    func start() {
        let chatHistoryViewModel = ChatHistoryViewModel()
        let chatHistoryViewController = ChatHistoryViewController(historyViewModel: chatHistoryViewModel)
        chatHistoryViewModel.coordinator = self
        navigationController?.pushViewController(chatHistoryViewController, animated: false)
    }
    
    
}
