//
//  AppDelegate.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   var window: UIWindow?
   
   func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
   -> Bool
   {
      window = UIWindow(frame: UIScreen.main.bounds)
      
      let tabBarController = TabBarController()
      window?.rootViewController = tabBarController
      window?.makeKeyAndVisible()
      return true
   }
}
