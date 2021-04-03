//
//  DataServiceProtocol.swift
//  QuizApp
//
//  Created by five on 02/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

protocol DataServiceProtocol {
    func login(email:String, password:String) ->LoginStatus
    func fetchQuizes() -> [Quiz]
}
