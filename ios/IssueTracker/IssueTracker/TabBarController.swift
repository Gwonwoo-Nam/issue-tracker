//
//  TabBarController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/14.
//

import UIKit

class TabBarController: UITabBarController {
   override func viewDidLoad() {
      super.viewDidLoad()
      setViewControllers()
   }
   
   func setViewControllers() {
      // issue
      let issueListStoryBoard = UIStoryboard(name: "IssueList", bundle: nil)
      guard let issueListController = issueListStoryBoard.instantiateInitialViewController() as? UINavigationController else { return }
      
      // label
      let labelListVC = LabelListViewController()
      let labelNavigationController = UINavigationController(rootViewController: labelListVC)
      labelNavigationController.navigationBar.prefersLargeTitles = true
      labelNavigationController.tabBarItem.title = "레이블"
      labelNavigationController.tabBarItem.image = UIImage(named: "tag")
      
      // milestone
      let milestoneListVC = MilestoneListViewController()
      let milestoneNavigationController = UINavigationController(rootViewController: milestoneListVC)
      milestoneNavigationController.navigationBar.prefersLargeTitles = true
      milestoneNavigationController.tabBarItem.title = "마일스톤"
      milestoneNavigationController.tabBarItem.image = UIImage(named: "milestone")
      
      // 내 계정
      let profileVC = UIViewController()
      profileVC.view.backgroundColor = .systemBackground
      profileVC.title = "내 계정"
      let profileNavigationController = UINavigationController(rootViewController: profileVC)
      profileNavigationController.navigationBar.prefersLargeTitles = true
      profileNavigationController.tabBarItem.title = "내 계정"
      profileNavigationController.tabBarItem.image = UIImage(named: "profileS")
      
      let controllers = [
         issueListController,
         labelNavigationController,
         milestoneNavigationController,
         profileNavigationController
      ]
      setViewControllers(controllers, animated: false)
   }
}
