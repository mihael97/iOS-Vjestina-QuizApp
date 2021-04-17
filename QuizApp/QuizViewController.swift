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
    private let offset: CGFloat = 10
    private let quiz:Quiz
    private var quizQuestion: QuizQuestion!
    
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
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            quizQuestion.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: offset),
            quizQuestion.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: offset),
            quizQuestion.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -offset),
            quizQuestion.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -offset),
        ])
    }
    
    private func buildView() {
        view.backgroundColor = .purple
        quizQuestion = QuizQuestion()
        quizQuestion.setQuiz(quiz: quiz)
        addToSubview(component: quizQuestion)
    }
    
    private func addToSubview(component: UIView) {
        component.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(component)
    }
}
