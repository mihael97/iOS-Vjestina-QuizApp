//
//  Question.swift
//  QuizApp
//
//  Created by five on 02/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

struct Question:Codable {
    let id: Int
    let question: String
    let answers: [String]
    let correctAnswer: Int
    
    enum QuestionKeys: String, CodingKey {
        case id
        case question
        case answers
        case correctAnswer = "correct_answer"
    }
}
