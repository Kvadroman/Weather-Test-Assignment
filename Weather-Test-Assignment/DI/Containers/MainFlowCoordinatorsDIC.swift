//
//  MainFlowCoordinatorsDIC.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Foundation
import Swinject
import UIKit

class MainFlowCoordinatorsDIC {
    let container: Container
    init(parentContainer: Container) {
        self.container = Container(parent: parentContainer) { container in
            // View Models
            container.register(CurrentLocationViewModel.self) { resolver in
                CurrentLocationViewModel(weatherRepo: resolver.resolve(WeatherRepositoryProtocol.self)!)
            }
            container.register(DetailsForecastViewModel.self) { (_, forecasts: [Forecast]?) in
                DetailsForecastViewModel(hourlyForecast: forecasts)
            }
            container.register(FindCityViewModel.self) { resolver in
                FindCityViewModel(weatherRepo: resolver.resolve(WeatherRepositoryProtocol.self)!)
            }
            
            // ViewControllers
            container.register(CurrentLocationViewController<CurrentLocationViewModel>.self) { resolver in
                let viewModel = resolver.resolve(CurrentLocationViewModel.self)!
                let viewController = CurrentLocationViewController(viewModel: viewModel)
                viewController.tabBarItem.image = UIImage(systemName: "sun.dust")
                viewController.tabBarItem.selectedImage = UIImage(systemName: "sun.dust.fill")
                viewController.tabBarItem.title = "Current Weather"
                viewController.weatherDateProcessor = resolver.resolve(WeatherDateProcessorProtocol.self)!
                return viewController
            }.inObjectScope(.container)
            container.register(DetailsForecastViewController<DetailsForecastViewModel>.self) { (resolver, forecasts: [Forecast]?) in
                let viewModel = resolver.resolve(DetailsForecastViewModel.self, argument: forecasts)!
                return DetailsForecastViewController(viewModel: viewModel)
            }
            container.register(FindCityViewController<FindCityViewModel>.self) { resolver in
                let viewModel = resolver.resolve(FindCityViewModel.self)!
                let viewController = FindCityViewController(viewModel: viewModel)
                viewController.tabBarItem.image = UIImage(systemName: "location.viewfinder")
                viewController.tabBarItem.selectedImage = UIImage(systemName: "location.fill.viewfinder")
                viewController.tabBarItem.title = "Find City"
                return viewController
            }.inObjectScope(.container)
            
            // CurrentLocation coordinator
            container.register(CurrentLocationCoordinator.self) { resolver in
                let currentLocationVC: () -> CurrentLocationViewController<CurrentLocationViewModel> = {
                    resolver.resolve(CurrentLocationViewController<CurrentLocationViewModel>.self)!
                }
                let detailsForecastVC: ([Forecast]?) -> DetailsForecastViewController<DetailsForecastViewModel> = { forecasts in
                    resolver.resolve(DetailsForecastViewController<DetailsForecastViewModel>.self, argument: forecasts)!
                }
                return CurrentLocationCoordinator(router: Router(),
                                                  currentLocationFactory: currentLocationVC,
                                                  detailsForecastFactory: detailsForecastVC)
            }
            
            // FindCityCoordinator coordinator
            container.register(FindCityCoordinator.self) { resolver in
                let findCityVC: () -> FindCityViewController<FindCityViewModel> = {
                    resolver.resolve(FindCityViewController<FindCityViewModel>.self)!
                }
                return FindCityCoordinator(router: Router(), findCityFactory: findCityVC)
            }
        }
    }
    
    func makeCurrentLocationCoordinator() -> CurrentLocationCoordinator { container.resolve(CurrentLocationCoordinator.self)! }
    func makeFindCityCoordinator() -> FindCityCoordinator {
        container.resolve(FindCityCoordinator.self)! }
}
