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
    private var quiz:Quiz!
    private var questionIndexLabel: UILabel!
    private var questionLabel: UILabel!
    private var questionIndex:Int=0
    private var progressBar: QuestionTrackerView!
    
    
    init(quiz: Quiz, frame: CGRect) {
        super.init(frame: frame)
        self.quiz = quiz
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        setConstraints()
        progressBar.setNeedsUpdateConstraints()
    }
    
    
    private func setConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        let offset = 0.1*max(self.frame.width, self.frame.height)

        NSLayoutConstraint.activate([
            questionIndexLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: offset),
            questionIndexLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            progressBar.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 0),
            progressBar.topAnchor.constraint(equalTo: questionIndexLabel.bottomAnchor, constant: max(offset, 10)),
            progressBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            progressBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            questionLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: max(offset, 10)),
            questionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            questionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            questionLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
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
        
        progressBar = QuestionTrackerView()
        progressBar.setUp(numberOfQuestions: quiz.questions.count)
                
        addToSubview(component: questionIndexLabel)
        addToSubview(component: questionLabel)
        addToSubview(component: progressBar)
    }
        
    private func addToSubview(component: UIView) {
        component.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(component)
    }
    
    public func setQuestion(index:Int, quiz: Quiz, correct: QuizQuestionResponse) {
        questionIndexLabel.text="\(index+1)/\(quiz.questions.count)"
        questionLabel.text=quiz.questions[index].question
        progressBar.updateQuestion(index: index-1, correct: correct)
    }
    
}
