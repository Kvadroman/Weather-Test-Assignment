//
//  AppDelegate.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let container = AppDependencyContainer()
    var window: UIWindow?
    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: Create appCoordinator
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = container.makeCoordinator()
        window?.rootViewController = appCoordinator.toPresentable()
        window?.makeKeyAndVisible()
        appCoordinator.start(with: .main)
        return true
    }
}
