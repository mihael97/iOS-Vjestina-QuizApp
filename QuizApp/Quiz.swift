//
//  Quiz.swift
//  QuizApp
//
//  Created by five on 02/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

struct Quiz:Codable {
    let id:Int
    let title:String
    let description:String
    let category: QuizCategory
    let level: Int
    let imageUrl: String
    let questions: [Question]
}
