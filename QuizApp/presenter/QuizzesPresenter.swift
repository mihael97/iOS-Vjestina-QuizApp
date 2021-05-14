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
    weak private var delegate: QuizzesViewDelegate?
    
    init(networkManager: NetworkServiceProtocol) {
        self.networkManager = networkManager
    }
    
    func setQuizzesViewDelegate(delegate: QuizzesViewDelegate) {
        self.delegate = delegate
    }
    
    func fetchQuizzes() {
        networkManager.fetchQuizzes(completation: {response in
                DispatchQueue.main.async {
                    switch response {
                        case .failure:
                            self.delegate?.getQuizzes(quizzes: [QuizCategory:[Quiz]]())
                        case .success(let arrayQuizzes):
                            self.delegate?.getQuizzes(quizzes: arrayQuizzes.reduce([:] as! [QuizCategory: [Quiz]], {
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
        )
    }
}
