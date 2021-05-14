//
//  AppRouterProtocol.swift
//  QuizApp
//
//  Created by five on 28/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

protocol AppRouterProtocol {
    func showLoginController()
    func showTabBarController()
    func showQuizViewController(quiz: Quiz)
    func showQuizResult(quizId: Int, correctAnswers: Int, total: Int)
    func popToRoot()
    func popBack()
    func setScreen(window: UIWindow?)
    func showQuizLeaderboard(quizId: Int)
    func dismissQuizLeaderBoard()
}
