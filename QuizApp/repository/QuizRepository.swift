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
    
    func fetchQuizzes(completion: @escaping ([Quiz])->Void) {
        if NetworkManager.networkManager.isInternetConnected() {
            networkDatabase.fetchQuizzes() {
                [weak self] quizzes in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.coreDataDatabase.refreshQuizzes(quizzes: quizzes)
                    var quizzes = self.coreDataDatabase.fetchQuizzes()
                    if quizzes.count == 0 {
                        quizzes = self.coreDataDatabase.fetchQuizzes()
                    }
                    completion(quizzes)
                }
            }
        } else {
            completion(self.coreDataDatabase.fetchQuizzes())
        }
    }
    
    func filterQuizzes(searchText: String) -> [QuizCategory: [Quiz]] {
        return coreDataDatabase.filterQuizzes(searchText: searchText).reduce([:] as! [QuizCategory: [Quiz]], {
            a, b in
                var map:[QuizCategory: [Quiz]] = a
                var value = map[b.category,default: []]
                value.append(b)
                map[b.category] = value
                return map
            }
        )
    }
}
