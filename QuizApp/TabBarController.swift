//
//  TabBarController.swift
//  QuizApp
//
//  Created by five on 20/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    private var router: AppRouterProtocol!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
        setUpFooter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpFooter() {
        let quizzesController = QuizzesViewController(router: router)
        quizzesController.tabBarItem = UITabBarItem(title: "Quiz", image: .add, selectedImage: .add)
        let settingsController = SettingsViewController(router: router)
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: .add, selectedImage:
        .add)
        self.viewControllers = [quizzesController, settingsController]
    }
}
