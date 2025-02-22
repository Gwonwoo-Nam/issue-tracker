//
//  SceneDelegate.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
   var window: UIWindow?
   
   func scene(
      _ scene: UIScene,
      willConnectTo session: UISceneSession,
      options connectionOptions: UIScene.ConnectionOptions)
   {
      guard let windowScene = (scene as? UIWindowScene) else { return }
      window = UIWindow(windowScene: windowScene)
      
      let tabBarController = TabBarController()
      window?.rootViewController = tabBarController
      window?.makeKeyAndVisible()
   }
}
