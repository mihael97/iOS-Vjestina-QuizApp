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
    private var networkManager: NetworkServiceProtocol!
    
    convenience init(router: AppRouterProtocol, networkManager: NetworkServiceProtocol) {
        self.init()
        self.router = router
        self.networkManager = networkManager
        setUpFooter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpFooter() {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)

        let quizzesController = QuizzesViewController(router: router, networkManager: networkManager)
        quizzesController.tabBarItem = UITabBarItem(title: "Quiz", image: nil, selectedImage: nil)
        let searchController = SearchQuizViewController(networkManager: networkManager)
        searchController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        let settingsController = SettingsViewController(router: router)
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: nil, selectedImage:
        nil)
        self.viewControllers = [quizzesController, searchController, settingsController]
    }
}
