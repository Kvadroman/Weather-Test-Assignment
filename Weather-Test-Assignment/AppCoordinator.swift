//
//  AppCoordinator.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

enum DeepLink {
    case main
}

import UIKit

class AppCoordinator: Coordinator<DeepLink> {
    
    private let mainTabBarCoordinator: (RouterType) -> MainFlowTabBarCoordinator
    
    init(router: RouterType,
         mainTabBarCoordinator: @escaping (RouterType) -> MainFlowTabBarCoordinator) {
        self.mainTabBarCoordinator = mainTabBarCoordinator
        super.init(router: router)
    }
    
    override func start(with link: DeepLink?) {
        guard let link else {
            return
        }
        switch link {
        case .main:
            goToMainFlow()
        }
    }
}

// MARK: - Navigation
extension AppCoordinator {
    func goToMainFlow() {
        childCoordinators.removeAll()
        let coordinator = mainTabBarCoordinator(router)
        addChild(coordinator)
        coordinator.start()
    }
}
