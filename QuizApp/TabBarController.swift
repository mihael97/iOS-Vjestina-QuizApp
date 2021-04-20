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
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUpFooter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpFooter() {
        let quizzesController = QuizzesViewController()
        quizzesController.tabBarItem = UITabBarItem(title: "Quiz", image: .add, selectedImage: .add)
        let settingsController = SettingsViewController()
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: .add, selectedImage:
        .add)
        self.viewControllers = [quizzesController, settingsController]
    }
}
