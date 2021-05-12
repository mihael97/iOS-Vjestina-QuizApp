//
//  QuizResult.swift
//  QuizApp
//
//  Created by five on 12/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

struct QuizResult: Codable {
    var quizId: Int
    var userId: Int
    var time: Double
    var numberOfCorrectAnswers: Int
    
    enum CodingKeys: String, CodingKey {
        case quizId = "quiz_id"
        case userId = "user_id"
        case time
        case numberOfCorrectAnswers = "no_of_correct"
    }
}
