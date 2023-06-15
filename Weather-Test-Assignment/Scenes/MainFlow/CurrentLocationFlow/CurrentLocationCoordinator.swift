//
//  CurrentLocationCoordinator.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Combine
import UIKit

final class CurrentLocationCoordinator: Coordinator<DeepLink> {
    private let currentLocationFactory: () -> CurrentLocationViewController<CurrentLocationViewModel>
    private let detailsForecastFactory: ([Forecast]?) -> DetailsForecastViewController<DetailsForecastViewModel>
    
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var currentLocationVC: UIViewController = {
        let viewController = currentLocationFactory()
        viewController.viewModel.output.onOpenDetailsForecast
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] forecasts in
                self?.openDetailsForecast(with: forecasts)
            }
            .store(in: &viewController.cancellables)
        return viewController
    }()
    
    init(router: RouterType,
         currentLocationFactory: @escaping () -> CurrentLocationViewController<CurrentLocationViewModel>,
         detailsForecastFactory: @escaping ([Forecast]?) -> DetailsForecastViewController<DetailsForecastViewModel>) {
        self.currentLocationFactory = currentLocationFactory
        self.detailsForecastFactory = detailsForecastFactory
        super.init(router: router)
    }
    
    override func start() {
        router.setRootModule(self, animated: true)
    }
    
    override func toPresentable() -> UIViewController { currentLocationVC }
}

extension CurrentLocationCoordinator {
    private func openDetailsForecast(with model: [Forecast]?) {
        let viewController = detailsForecastFactory(model)
        router.push(viewController, animated: true)
    }
}
