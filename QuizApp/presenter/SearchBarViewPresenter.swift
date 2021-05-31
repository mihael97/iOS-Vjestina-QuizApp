//
//  SearchBarViewPresenter.swift
//  QuizApp
//
//  Created by five on 22/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

class SearchBarViewPresenter {
    private var repository:QuizRepository?
    private var router: AppRouterProtocol!
    weak private var delegate: SearchBarViewDelegate?
    
    init(networkManager: NetworkServiceProtocol, router: AppRouterProtocol) {
        self.repository = QuizRepository(networkManager: networkManager)
        self.router = router
    }
        
    func setDelegate(delegate: SearchBarViewDelegate) {
        self.delegate = delegate
    }
    
    func fetchQuizzes(searchText: String) {
        delegate?.searchResults(quizzes: repository!.filterQuizzes(searchText: searchText))
    }
    
}

extension SearchBarViewPresenter: ShowQuizExtension {
    func showQuiz(quiz: Quiz) {
        router.showQuizViewController(quiz: quiz)
    }
}
