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
    weak private var delegate: QuizzesViewDelegate?
    
    init(networkManager: NetworkServiceProtocol) {
        self.networkManager = networkManager
        self.repository = QuizRepository(networkManager: networkManager)
    }
    
    func setQuizzesViewDelegate(delegate: QuizzesViewDelegate) {
        self.delegate = delegate
    }
    
    func fetchQuizzes() {
        let quizzes: [Quiz] = repository.fetchQuizzes()
        self.delegate?.getQuizzes(quizzes: quizzes.reduce([:] as! [QuizCategory: [Quiz]], {
            a, b in
                var map:[QuizCategory: [Quiz]] = a
                var value = map[b.category,default: []]
                value.append(b)
                map[b.category] = value
                return map
>>>>>>> Model
            }
        ))
    }
}
