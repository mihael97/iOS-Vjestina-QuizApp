//
//  QuizResultPresenter.swift
//  QuizApp
//
//  Created by five on 14/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

class QuizResultPresenter {
    private let router: AppRouterProtocol
    
    init(router: AppRouterProtocol) {
        self.router = router
    }
    
    func showTabBarController() {
        router.showTabBarController()
    }
    
    func showLeaderboard(quizId: Int) {
        router.showQuizLeaderboard(quizId: quizId)
    }
}
