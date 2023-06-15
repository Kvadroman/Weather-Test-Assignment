//
//  MainTabBarCoordinator.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import UIKit

final class MainFlowTabBarCoordinator: Coordinator<DeepLink> {
    private var tabs: [UIViewController: Coordinator<DeepLink>] = [:]
    // Coordinators
    private let currentLocationCoordinatorFactory: () -> CurrentLocationCoordinator
    private let findCityCoordinatorFactory: () -> FindCityCoordinator
    // ViewControllers
    private let mainTabBarControllerFactory: () -> MainTabBarController<MainTabBarViewModel>
    
    private lazy var tabController: UITabBarController = {
        let viewController = mainTabBarControllerFactory()
        return viewController
    }()
    
    init(router: RouterType,
         currentLocationCoordinatorFactory: @escaping () -> CurrentLocationCoordinator,
         findCityCoordinatorFactory: @escaping () -> FindCityCoordinator,
         mainTabBarControllerFactory: @escaping () -> MainTabBarController<MainTabBarViewModel>
    ) {
        self.currentLocationCoordinatorFactory = currentLocationCoordinatorFactory
        self.findCityCoordinatorFactory = findCityCoordinatorFactory
        self.mainTabBarControllerFactory = mainTabBarControllerFactory
        super.init(router: router)
    }
    
    override func start() {
        let currentLocationCoordinator = currentLocationCoordinatorFactory()
        currentLocationCoordinator.start()
        
        let findCityCoordinator = findCityCoordinatorFactory()
        findCityCoordinator.start()
        
        setTabs([currentLocationCoordinator, findCityCoordinator], animated: true)
        router.navigationController.setNavigationBarHidden(true, animated: true)
        router.setRootModule(self, animated: true)
    }
    
    private func setTabs(_ coordinators: [Coordinator<DeepLink>], animated: Bool = false) {
        tabs = [:]
        
        let viewControllers = coordinators.map { coordinator -> UIViewController in
            let viewController = coordinator.router.navigationController
            viewController.navigationBar.prefersLargeTitles = true
            tabs[viewController] = coordinator
            return viewController
        }
        
        tabController.setViewControllers(viewControllers, animated: animated)
    }
    
    override func toPresentable() -> UIViewController { tabController }
}
