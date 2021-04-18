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
    private var questionIndex: Int=0
    private var answerButtons: [AnswerButton]!
    private var correctAnswers:Int
    
    init(quiz:Quiz) {
        self.quiz=quiz
        correctAnswers = self.quiz.questions.count
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
            quizQuestion.trailingAnchor.constraint(equalTo:safeArea.trailingAnchor, constant: -offset),
        ])
        
        var constraints:[NSLayoutConstraint]=[]
        for (i, element) in answerButtons.enumerated() {
            constraints.append(element.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20))
            constraints.append(element.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20))

            if i==0 {
                constraints.append(element.topAnchor.constraint(equalTo: quizQuestion.bottomAnchor, constant: 40))
            } else {
                constraints.append(element.topAnchor.constraint(equalTo: answerButtons[i-1].bottomAnchor, constant: 20))
            }
        }

        NSLayoutConstraint.activate(constraints)
    }
    
    private func buildView() {
        view.backgroundColor = .purple
        quizQuestion = QuizQuestion()
        quizQuestion.setQuiz(index: questionIndex, quiz: quiz)
        addToSubview(component: quizQuestion)
        
        answerButtons=[]
        for _ in 0...3 {
            let button = AnswerButton()
            button.addTarget(self, action: #selector(QuizViewController.answerClicked(_:)), for: .touchUpInside)
            button.layer.cornerRadius = CGFloat(10)
            answerButtons.append(button)
            addToSubview(component: button)
        }
        
        advanceInQuestion()
    }
    
    @objc
    private func answerClicked(_ sender:AnswerButton) {
        let correctAnswer:Int=quiz.questions[questionIndex-1].correctAnswer
        answerButtons[correctAnswer].backgroundColor = .green
        if correctAnswer != sender.getIndex() {
            answerButtons[sender.getIndex()].backgroundColor = .red
            self.correctAnswers-=1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.advanceInQuestion()
        }
    }
    
    private func advanceInQuestion() {
        if questionIndex==quiz.questions.count {
            let controller = QuizResultViewController(correct: correctAnswers, total: quiz.questions.count)
            self.navigationController?.pushViewController(controller, animated: true)
            return
        }
        quizQuestion.setQuiz(index: questionIndex, quiz: quiz)
        for (i, answer) in quiz.questions[questionIndex].answers.enumerated() {
            answerButtons[i].backgroundColor = .systemPurple
            answerButtons[i].setUp(title: answer,index: i)
        }
        questionIndex+=1
    }
    
    private func addToSubview(component: UIView) {
        component.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(component)
    }
}
