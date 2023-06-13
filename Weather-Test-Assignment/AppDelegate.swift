//
//  AppDelegate.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 13.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController()
        window?.backgroundColor = .blue
        window?.makeKeyAndVisible()
        return true
    }
}

