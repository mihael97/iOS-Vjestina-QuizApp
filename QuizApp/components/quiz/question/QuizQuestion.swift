//
//  QuizQuestion.swift
//  QuizApp
//
//  Created by five on 17/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuizQuestion: UIView {
    public var quiz:Quiz!
    private var questionIndexLabel: UILabel!
    private var questionLabel: UILabel!
    private var questionIndex: Int = 0
    private var questionAnswers: QuestionAnswers!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            questionIndexLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            questionIndexLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            questionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            questionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            questionLabel.bottomAnchor.constraint(equalTo: safeArea.topAnchor, constant: 150),
            questionAnswers.leadingAnchor.constraint(equalTo:safeArea.leadingAnchor, constant: 0),
            questionAnswers.trailingAnchor.constraint(equalTo:safeArea.trailingAnchor, constant: 0),
            questionAnswers.bottomAnchor.constraint(equalTo: safeArea.topAnchor, constant: 200)
        ])
    }
    
    private func buildView() {
        self.backgroundColor = .purple
        
        questionIndexLabel=UILabel()
        questionIndexLabel.textColor = .white
        questionIndexLabel.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        
        questionLabel = UILabel()
        questionLabel.textColor = .white
        questionLabel.font = UIFont.boldSystemFont(ofSize: 25)
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
        
        questionAnswers = QuestionAnswers()
        
        advanceWithQuestion()
        
        addToSubview(component: questionIndexLabel)
        addToSubview(component: questionLabel)
        addToSubview(component: questionAnswers)
    }
    
    private func addToSubview(component: UIView) {
        component.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(component)
    }
    
    private func advanceWithQuestion() {
        questionIndex+=1
        if questionIndex >= quiz.questions.count {
            return
        }
        questionIndexLabel.text = "\(String(describing: questionIndex))/\(quiz.questions.count)"
        let question:Question = quiz.questions[questionIndex-1]
        questionAnswers.setUp(question: question)
        questionLabel.text=question.question
    }
    
    public func setQuiz(quiz: Quiz) {
        self.quiz=quiz
        buildView()
        setConstraints()
    }
}
