//
//  QuestionAnswers.swift
//  QuizApp
//
//  Created by five on 17/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuestionAnswers: UIView {
    private var answerButtons: [AnswerButton]!
    private var question: Question!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        for (i,element) in answerButtons.enumerated() {
            var constraints: [NSLayoutConstraint]=[]
            constraints.append(element.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
            constraints.append(element.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0))

            if i==0 {
                constraints.append(element.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
            } else {
                constraints.append(element.topAnchor.constraint(equalTo: answerButtons[i-1].bottomAnchor, constant: 15))
            }
            
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    private func buildView() {
        answerButtons=[]
        for i in 0...3 {
            let answerButton:AnswerButton = AnswerButton()
            answerButton.answerIndex=i
            answerButton.addTarget(self, action: #selector(QuestionAnswers.buttonClicked), for: .editingChanged)
            
            self.addSubview(answerButton)
            answerButton.translatesAutoresizingMaskIntoConstraints = false
            answerButtons.append(answerButton)
        }
    }
    
    @objc
    private func buttonClicked(button: AnswerButton) {
        answerButtons[question.correctAnswer].backgroundColor = .green
        if question.correctAnswer != button.answerIndex {
            answerButtons[button.answerIndex].backgroundColor = .red
        }
    }
    
    public func setUp(question:Question) {
        self.question=question
        for (i,answer) in question.answers.enumerated() {
            answerButtons[i].setUp(title: answer, index: i)
        }
    }
}
