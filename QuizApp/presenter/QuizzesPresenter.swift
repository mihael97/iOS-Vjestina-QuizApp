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
    private let router: AppRouterProtocol
    weak private var delegate: QuizzesViewDelegate?
    
    init(networkManager: NetworkServiceProtocol, router: AppRouterProtocol) {
        self.networkManager = networkManager
        self.router = router
    }
    
    func setQuizzesViewDelegate(delegate: QuizzesViewDelegate) {
        self.delegate = delegate
    }
    
    func fetchQuizzes() {
        networkManager.fetchQuizzes(completation: {[weak self]response in
                DispatchQueue.main.async {
                    guard let self=self else {return}
                    switch response {
                        case .failure:
                            self.delegate?.getQuizzes(quizzes: [QuizCategory:[Quiz]]())
                        case .success(let arrayQuizzes):
                            self.delegate?.getQuizzes(quizzes: arrayQuizzes.reduce([:] as! [QuizCategory: [Quiz]], {
                                    items, quiz in
                                        var map:[QuizCategory: [Quiz]] = items
                                        var value = map[quiz.category,default: []]
                                        value.append(quiz)
                                        map[quiz.category] = value
                                        return map
                                }
                            ))
                    }
                }
            }
        )
    }
}
