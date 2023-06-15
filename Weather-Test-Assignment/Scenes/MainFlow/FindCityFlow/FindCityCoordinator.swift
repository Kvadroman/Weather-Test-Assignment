//
//  FindCityCoordinator.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import Combine
import UIKit

final class FindCityCoordinator: Coordinator<DeepLink> {
    private let findCityFactory: () -> FindCityViewController<FindCityViewModel>
    
    private var cancellables: Set<AnyCancellable> = []
    
    private lazy var findCityVC: UIViewController = {
        let viewController = findCityFactory()
        return viewController
    }()
    
    init(router: RouterType,
         findCityFactory: @escaping () -> FindCityViewController<FindCityViewModel>) {
        self.findCityFactory = findCityFactory
        super.init(router: router)
    }
    
    override func start() {
        router.setRootModule(self, animated: true)
    }
    
    override func toPresentable() -> UIViewController { findCityVC }
}
