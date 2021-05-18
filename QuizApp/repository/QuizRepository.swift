//
//  QuizRepository.swift
//  QuizApp
//
//  Created by five on 17/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

class QuizRepository {
    private let coreDataDatabase: QuizDatabaseDataSource
    private let networkDatabase: QuizNetworkDataSource
    
    init(networkManager: NetworkServiceProtocol) {
        self.coreDataDatabase = QuizDatabaseDataSource()
        self.networkDatabase = QuizNetworkDataSource(networkManager: networkManager, coreDataDatabase: self.coreDataDatabase)
    }
    
    func fetchQuizzes() -> [Quiz] {
        var quizzes = networkDatabase.fetchQuizzes()
        if quizzes.count == 0 {
            quizzes = coreDataDatabase.fetchQuizzes()
        }
        
        return quizzes
    }
}