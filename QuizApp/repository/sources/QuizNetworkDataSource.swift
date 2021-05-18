//
//  QuizNetworkDataSource.swift
//  QuizApp
//
//  Created by five on 17/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

class QuizNetworkDataSource {
    private let networkManager: NetworkServiceProtocol
    weak private var coreDataDatabase: QuizDatabaseDataSource!
    
    init(networkManager: NetworkServiceProtocol, coreDataDatabase: QuizDatabaseDataSource) {
        self.networkManager = networkManager
        self.coreDataDatabase = coreDataDatabase
    }
    
    func fetchQuizzes () -> [Quiz]{
        let semaphore = DispatchSemaphore(value: 0)
        var quizzes: [Quiz] = []
        networkManager.fetchQuizzes(completation: {response in
                switch response {
                    case .failure:
                        quizzes = []
                    case .success(let arrayQuizzes):
                        self.coreDataDatabase.refreshQuizzes(quizzes: arrayQuizzes)
                        quizzes = Array(arrayQuizzes)
                }
            }
        )
        semaphore.wait()
        return quizzes
    }
}
