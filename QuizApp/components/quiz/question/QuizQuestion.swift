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
    private var questionIndex:Int=0
    private var progressBar: ProgressBar!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setConstraints() {
        let safeArea = self.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            questionIndexLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            questionIndexLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            progressBar.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 0),
            progressBar.topAnchor.constraint(equalTo: questionIndexLabel.bottomAnchor, constant: self.frame.height*0.2),
            questionLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 50),
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
        
        progressBar = ProgressBar()
                
        addToSubview(component: questionIndexLabel)
        addToSubview(component: questionLabel)
        addToSubview(component: progressBar)
    }
        
    private func addToSubview(component: UIView) {
        component.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(component)
    }
    
    public func setQuestion(index:Int, quiz: Quiz) {
        questionIndexLabel.text="\(index+1)/\(quiz.questions.count)"
        questionLabel.text=quiz.questions[index].question
        progressBar.setProgress(Float(index)/Float(quiz.questions.count), animated: true)
    }
    
}
