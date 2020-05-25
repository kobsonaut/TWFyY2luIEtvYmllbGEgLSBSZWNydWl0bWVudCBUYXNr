//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Kobsonauta on 21/05/2020.
//  Copyright © 2020 Kobsonauta. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Members
    private var webserviceCommunicator = WebserviceCommunicator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        customizeNavigationBar()
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Helpers
    private func customizeNavigationBar() {
        // Navigation bar
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .clientWhite
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clientWhite]
        navigationBarAppearace.barTintColor = .clientMain
        navigationBarAppearace.isTranslucent = false
        navigationBarAppearace.barStyle = .black
        navigationBarAppearace.setBackgroundImage(UIImage(), for:.default)
        navigationBarAppearace.shadowImage = UIImage()
    }
}

