//
//  SearchBarViewDelegate.swift
//  QuizApp
//
//  Created by five on 22/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

protocol SearchBarViewDelegate: NSObjectProtocol {
    func searchResults(quizzes: [QuizCategory:[Quiz]])
}
