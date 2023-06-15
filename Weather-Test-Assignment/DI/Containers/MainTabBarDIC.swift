//
//  MainTabBarDIC.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Swinject

class MainTabBarDIContainer {
    private let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer) { container in
            // MARK: - ViewModels
            container.register(MainTabBarViewModel.self) { _ in
                MainTabBarViewModel()
            }
            
            // MARK: - ViewControllers
            container.register(MainTabBarController<MainTabBarViewModel>.self) { resolver in
                let viewController = MainTabBarController(viewModel: resolver.resolve(MainTabBarViewModel.self)!)
                viewController.tabBar.isTranslucent = false
                viewController.tabBar.backgroundColor = .white
                return viewController
            }
        }
    }
    
    func makeMainTabBarController() -> MainTabBarController<MainTabBarViewModel> { container.resolve(MainTabBarController.self)!
    }
}
