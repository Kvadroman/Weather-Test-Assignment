//
//  Coordinator.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import UIKit

public protocol BaseCoordinatorType: AnyObject {
    associatedtype DeepLinkType
    func start()
    func start(with link: DeepLinkType?)
}

public protocol PresentableCoordinatorType: BaseCoordinatorType, Presentable {}

open class PresentableCoordinator<DeepLinkType>: NSObject, PresentableCoordinatorType {
    
    public override init() {
        super.init()
    }
    
    open func start() { start(with: nil) }
    open func start(with link: DeepLinkType?) {}

    open func toPresentable() -> UIViewController {
        fatalError("Must override toPresentable()")
    }
}

public protocol CoordinatorType: PresentableCoordinatorType {
    var router: RouterType { get }
}

open class Coordinator<DeepLinkType>: PresentableCoordinator<DeepLinkType>, CoordinatorType {
    
    public var childCoordinators: [Coordinator<DeepLinkType>] = []
    
    open var router: RouterType
    
    public init(router: RouterType) {
        self.router = router
        super.init()
    }
    
    public func addChild(_ coordinator: Coordinator<DeepLinkType>) {
        childCoordinators.append(coordinator)
    }
    
    public func removeChild(_ coordinator: Coordinator<DeepLinkType>?) {
        guard let coordinator, let index = childCoordinators.firstIndex(of: coordinator) else {
            return
        }
        childCoordinators.remove(at: index)
    }
    
    open override func toPresentable() -> UIViewController {
        router.toPresentable()
    }
}
