//
//  SearchBarViewPresenter.swift
//  QuizApp
//
//  Created by five on 22/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

class SearchBarViewPresenter {
    private var coreDataStack:QuizRepository?
    weak private var delegate: SearchBarViewDelegate?
    
    init(networkManager: NetworkServiceProtocol) {
        self.coreDataStack = QuizRepository(networkManager: networkManager)
    }
        
    func setDelegate(delegate: SearchBarViewDelegate) {
        self.delegate = delegate
    }
    
    func fetchQuizzes(searchText: String) {
        delegate?.searchResults(quizzes: coreDataStack!.filterQuizzes(searchText: searchText))
    }
    
}
