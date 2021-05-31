//
//  QuizzesPresenter.swift
//  QuizApp
//
//  Created by five on 14/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

class QuizzesPresenter {
    private let networkManager: NetworkServiceProtocol
    private let repository: QuizRepository
    private let router: AppRouterProtocol
    weak private var delegate: QuizzesViewDelegate?
    
    init(router:AppRouterProtocol, networkManager: NetworkServiceProtocol) {
        self.networkManager = networkManager
        self.router = router
        self.repository = QuizRepository(networkManager: networkManager)
    }
    
    func setQuizzesViewDelegate(delegate: QuizzesViewDelegate) {
        self.delegate = delegate
    }
    
    func fetchQuizzes() {
        repository.fetchQuizzes() {
            [weak self] quizzes in
                self?.delegate?.getQuizzes(quizzes: quizzes.reduce([:] as! [QuizCategory: [Quiz]], {
                    a, b in
                        var map:[QuizCategory: [Quiz]] = a
                        var value = map[b.category,default: []]
                        value.append(b)
                        map[b.category] = value
                        return map
                    }
                ))
        }
    }
}

extension QuizzesPresenter: ShowQuizExtension {
    func showQuiz(quiz: Quiz) {
        router.showQuizViewController(quiz: quiz)
    }
}
