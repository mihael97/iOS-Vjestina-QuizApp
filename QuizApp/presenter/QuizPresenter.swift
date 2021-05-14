//
//  QuizPresenter.swift
//  QuizApp
//
//  Created by five on 14/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

class QuizPresenter  {
    private let networkManager: NetworkServiceProtocol
    private let quiz: Quiz
    private let router: AppRouterProtocol
    private var questionIndex = 0
    private var startTime: Int64 = -1
    private var correctAnswers = 0
    weak private var delegate: QuizViewDelegate?
    
    init(quiz: Quiz, router: AppRouterProtocol, networkManager: NetworkServiceProtocol) {
        self.networkManager = networkManager
        self.router = router
        self.quiz = quiz
    }
    
    func setQuizViewDelegate(delegate: QuizViewDelegate) {
        self.delegate = delegate
    }
    
    private func publishQuizResults(time: Double) {
        networkManager.publishQuizResults(quizId: quiz.id, time: time, numberOfCorrectAnswers: correctAnswers) {
          (response) in
            switch response {
                case .success:
                    DispatchQueue.main.async {
                        self.router.showQuizResult(quizId: self.quiz.id, correctAnswers: self.correctAnswers, total: self.quiz.questions.count)
                    }
                case .failure(let status):
                    self.delegate?.questionPublishError(result: status)
            }
        }
    }
    
    func advanceInQuestion(answer: QuizQuestionResponse) {
        if questionIndex == 0 {
            startTime = Int64(Date().timeIntervalSince1970*1000)
        }
        if questionIndex==quiz.questions.count {
            let timeConsumption: Double = Double(Int64(Date().timeIntervalSince1970*1000)-startTime)/1000
            startTime = -1
            publishQuizResults(time: timeConsumption)
            return
        }
        self.delegate?.advanceInQuestion(result: answer, questionIndex: questionIndex)
        questionIndex+=1
    }
    
    func answerClicked(answerClicked: Int) {
        let correctAnswer:Int=quiz.questions[questionIndex-1].correctAnswer
        var wrongResult: Int? = nil
        if correctAnswer != answerClicked {
            self.correctAnswers-=1
            wrongResult = answerClicked
        }
        delegate?.answerClickedResult(correctResult: correctAnswer, wrongResult: wrongResult)
    }
    
    func popBack() {
        DispatchQueue.main.async {
            router.popBack()
        }
    }
}
