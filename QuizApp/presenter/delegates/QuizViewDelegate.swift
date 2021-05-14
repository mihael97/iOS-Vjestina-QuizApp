//
//  QuizViewDelegate.swift
//  QuizApp
//
//  Created by five on 14/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

protocol QuizViewDelegate: NSObject {
    func advanceInQuestion(result: QuizQuestionResponse, questionIndex: Int)
    func questionPublishError(result: ResponseCodeError)
    func answerClickedResult(correctResult: Int, wrongResult: Int?)
    func popBack()
}
