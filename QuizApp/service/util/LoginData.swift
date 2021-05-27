//
//  LoginData.swift
//  QuizApp
//
//  Created by five on 25/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

struct LoginData: Codable {
    let token: String
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case token
        case userId = "user_id"
    }
}
