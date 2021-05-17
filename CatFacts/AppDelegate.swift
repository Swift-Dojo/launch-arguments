//
//  AppDelegate.swift
//  CatFacts
//
//  Created by David Castro Cisneros on 07/05/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
    
}

