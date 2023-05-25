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
      let issueListStoryBoard = UIStoryboard(name: "IssueList", bundle: nil)
      guard let issueListController = issueListStoryBoard.instantiateInitialViewController() as? UINavigationController else { return }
      
      let labelListStoryBoard = UIStoryboard(name: "LabelList", bundle: nil)
      guard let labelListController = labelListStoryBoard.instantiateInitialViewController() as? UINavigationController else { return }
      
      let controllers = [issueListController, labelListController]
      setViewControllers(controllers, animated: false)
   }
}
