//
//  QuizViewController.swift
//  QuizApp
//
//  Created by five on 16/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuizViewController: UIViewController {
    private let quiz:Quiz
    private var questionLabel: UILabel!
    private var questionIndex: Int!
    
    init(quiz:Quiz) {
        self.quiz=quiz
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        buildView()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        ])
    }
    
    private func buildView() {
        questionIndex=1
        questionLabel=UILabel()
        questionLabel.text = "\(1)/\(quiz.questions.count)"
        
        addToSubview(component: questionLabel)
    }
    
    private func addToSubview(component: UIView) {
        component.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(component)
    }
}
