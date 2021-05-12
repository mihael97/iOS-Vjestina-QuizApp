//
//  AppRouter.swift
//  QuizApp
//
//  Created by five on 28/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!
    private let networkManager: NetworkServiceProtocol!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.networkManager = NetworkServiceProtocol()
    }
    
    func popToRoot() {
        self.navigationController.popToRootViewController(animated: true)
    }
    
    func popBack() {
        self.navigationController.popViewController(animated: true)
    }

    func showTabBarController() {
        var found: UIViewController?
        if let viewControllers = self.navigationController?.viewControllers {
              for vc in viewControllers {
                   if vc.isKind(of: TabBarController.classForCoder()) {
                        found = vc
                        break
                   }
              }
        }
        if let found = found {
            self.navigationController.popToViewController(found, animated: true)
        } else {
            let vc = TabBarController(router: self, networkManager: networkManager)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
        
    func showLoginController() {
        navigationController.setViewControllers([LoginViewController(router: self, manager: networkManager)], animated: true)
    }
    
    func showQuizViewController(quiz: Quiz) {
        navigationController.pushViewController(QuizViewController(quiz: quiz, router: self, manager: networkManager), animated: true)
    }
    
    func setScreen(window: UIWindow?) {
        let controller = LoginViewController(router: self, manager: networkManager)
        navigationController.pushViewController(controller, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showQuizResult(quizId: Int, correctAnswers:Int, total: Int) {
        let controller = QuizResultViewController(quizId: quizId, correct: correctAnswers, total: total, router: self)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showQuizLeaderboard(quizId: Int) {
        navigationController.present(LeaderboardViewController(quizId: quizId, router: self), animated: true)
    }
    
    func dismissQuizLeaderBoard() {
        navigationController.dismiss(animated: true)
    }
    
}
