//
//  AppDependencyContainer.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Foundation
import Swinject

class AppDependencyContainer {
    private lazy var appDIContainer: Container = {
        Container { container in
            // MARK: - Router
            container.register(RouterType.self) { _ in
                Router()
            }.inObjectScope(.weak)
            
            // MARK: - CL Manager
            container.register(CLManagerProtocol.self) { _ in
                CLManager()
            }.inObjectScope(.container)
            
            // MARK: - Network Repository
            container.register(NetworkRepositoryProtocol.self) { _ in
                NetworkRepository()
            }.inObjectScope(.container)
            
            // MARK: - Weather Repository
            container.register(WeatherRepositoryProtocol.self) { resolver in
                WeatherRepository(clManager: resolver.resolve(CLManagerProtocol.self)!,
                                  networkRepository: resolver.resolve(NetworkRepositoryProtocol.self)!)
            }.inObjectScope(.container)
            
            // MARK: - WeatherDate Processor
            container.register(WeatherDateProcessorProtocol.self) { _ in
                WeatherDateProcessor()
            }.inObjectScope(.container)
            
            // MARK: - MainFlowTabBar Coordinator
            container.register(MainFlowTabBarCoordinator.self) { (resolver, router: RouterType) in
                let mainFlowDIC = MainFlowCoordinatorsDIC(parentContainer: container)
                let mainTabBarDIC = MainTabBarDIContainer(parentContainer: container)
                return MainFlowTabBarCoordinator(router: router,
                                                 currentLocationCoordinatorFactory: mainFlowDIC.makeCurrentLocationCoordinator,
                                                 findCityCoordinatorFactory: mainFlowDIC.makeFindCityCoordinator,
                                                 mainTabBarControllerFactory: mainTabBarDIC.makeMainTabBarController)
            }
            
            // MARK: - App Coordinator
            container.register(AppCoordinator.self) { resolver in
                let router = resolver.resolve(RouterType.self)!
                let cardCoordinator: (RouterType) -> MainFlowTabBarCoordinator = { router in
                    resolver.resolve(MainFlowTabBarCoordinator.self, argument: router)!
                }
                return AppCoordinator(router: Router(), mainTabBarCoordinator: cardCoordinator)
            }.inObjectScope(.container)
        }
    }()
    
    func makeCoordinator() -> AppCoordinator {
        appDIContainer.resolve(AppCoordinator.self)!
    }
}

