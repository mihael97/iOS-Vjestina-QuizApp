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
    private var quiz: Quiz!
    private var quizQuestion: QuizQuestion!
    private var questionIndex: Int=0
    private var answerButtons: [AnswerButton]!
    private var correctAnswers: Int!
    private var router: AppRouterProtocol!
    private var manager: NetworkServiceProtocol!
    private var startTime: Int64! = -1
        
    convenience init (quiz: Quiz, router: AppRouterProtocol, manager: NetworkServiceProtocol) {
        self.init()
        self.quiz = quiz
        self.correctAnswers = quiz.questions.count
        self.router = router
        self.manager = manager
    }
    
    override func viewDidLoad() {
        setNavbar()
        buildView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        quizQuestion.setNeedsUpdateConstraints()
        setConstraints()
    }
    
    private func setNavbar() {
        let image = UIImage(systemName: "chevron.left")
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: image, style: .done, target: self, action: #selector(popBack))
        
        let appNameLabel = UILabel()
        appNameLabel.text = "Pop Quiz"
        appNameLabel.font = UIFont(name: "ArialRoundedMTBold", size: 25.0)
        appNameLabel.textColor = .systemYellow
        navigationItem.titleView = appNameLabel
        self.navigationController?.navigationBar.barTintColor = .purple
    }
    
    @objc
    func popBack() {
        router.popBack()
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let offset: CGFloat = 0.025*max(view.frame.width, view.frame.height)

        
        NSLayoutConstraint.activate([
            quizQuestion.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: offset),
            quizQuestion.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: offset),
            quizQuestion.trailingAnchor.constraint(equalTo:safeArea.trailingAnchor, constant: -offset),
        ])
        
        var constraints:[NSLayoutConstraint]=[]
        for (i, element) in answerButtons.enumerated() {
            constraints.append(element.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: offset*2))
            constraints.append(element.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -offset*2))

            if i==0 {
                constraints.append(element.topAnchor.constraint(equalTo: quizQuestion.bottomAnchor, constant: offset*2))
            } else {
                constraints.append(element.topAnchor.constraint(equalTo: answerButtons[i-1].bottomAnchor, constant: offset))
            }
        }

        NSLayoutConstraint.activate(constraints)
    }
    
    private func buildView() {
        view.backgroundColor = .purple
        quizQuestion = QuizQuestion(quiz: quiz, frame: .zero)
        addToSubview(component: quizQuestion)
        
        answerButtons=[]
        for _ in 0...3 {
            let button = AnswerButton()
            button.addTarget(self, action: #selector(QuizViewController.answerClicked(_:)), for: .touchUpInside)
            button.layer.cornerRadius = CGFloat(10)
            answerButtons.append(button)
            addToSubview(component: button)
        }
        
        advanceInQuestion(answer: .EMPTY)
    }
    
    @objc
    private func answerClicked(_ sender:AnswerButton) {
        let correctAnswer:Int=quiz.questions[questionIndex-1].correctAnswer
        answerButtons[correctAnswer].backgroundColor = .green
        var response: QuizQuestionResponse = .CORRECT
        if correctAnswer != sender.getIndex() {
            answerButtons[sender.getIndex()].backgroundColor = .red
            self.correctAnswers-=1
            response = .INCORRECT
        }
        
        for (i, element) in answerButtons.enumerated() {
            if i == sender.getIndex() {
                continue
            }
            element.isEnabled = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.advanceInQuestion(answer: response)
        }
    }
    
    private func advanceInQuestion(answer: QuizQuestionResponse) {
        if questionIndex == 0 {
            startTime = Int64(Date().timeIntervalSince1970*1000)
        }
        if questionIndex==quiz.questions.count {
            let timeConsumption: Double = Double(Int64(Date().timeIntervalSince1970*1000)-startTime)/1000
            startTime = -1
            manager.publishQuizResults(quizId: quiz.id, time: timeConsumption, numberOfCorrectAnswers: correctAnswers) {
              (response) in
                DispatchQueue.main.async {
                    switch response {
                        case .success:
                            self.router.showQuizResult(quizId: self.quiz.id, correctAnswers: self.correctAnswers, total: self.quiz.questions.count)
                        case .failure(_):
                            print("Failure")
                    }
                }
            }
            return
        }
        quizQuestion.setQuestion(index: questionIndex, quiz: quiz, correct: answer)
        for (i, answer) in quiz.questions[questionIndex].answers.enumerated() {
            answerButtons[i].backgroundColor = .systemPurple
            answerButtons[i].setUp(title: answer,index: i)
            answerButtons[i].isEnabled = true
        }
        questionIndex+=1
    }
    
    private func addToSubview(component: UIView) {
        component.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(component)
    }
}
