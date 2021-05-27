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
    private var answerButtons: [AnswerButton]!
    private var errorLabel: UILabel!
    private var presenter: QuizPresenter!
        
    convenience init (quiz: Quiz, router: AppRouterProtocol, manager: NetworkServiceProtocol) {
        self.init()
        self.quiz = quiz
        self.presenter = QuizPresenter(quiz: quiz, router: router, networkManager: manager)
    }
    
    override func viewDidLoad() {
        presenter.setQuizViewDelegate(delegate: self)
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
        self.presenter.popBack()
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
        
        constraints.append(errorLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 0))
        constraints.append(errorLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -offset))

        NSLayoutConstraint.activate(constraints)
    }
    
    private func buildView() {
        view.backgroundColor = .purple
        quizQuestion = QuizQuestion(quiz: quiz, frame: .zero)
        addToSubview(component: quizQuestion)
        errorLabel = UILabel()
        errorLabel.textColor = .red
        errorLabel.backgroundColor = .white
        addToSubview(component: errorLabel)
        
        answerButtons=[]
        for _ in 0...3 {
            let button = AnswerButton()
            button.addTarget(self, action: #selector(QuizViewController.answerClicked(_:)), for: .touchUpInside)
            button.layer.cornerRadius = CGFloat(10)
            answerButtons.append(button)
            addToSubview(component: button)
        }
        
        presenter.advanceInQuestion(answer: .EMPTY)
    }
    
    @objc
    private func answerClicked(_ sender:AnswerButton) {
        presenter.answerClicked(answerClicked: sender.getIndex())
    }
    
    
    private func addToSubview(component: UIView) {
        component.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(component)
    }
}

extension QuizViewController: QuizViewDelegate {
    func answerClickedResult(correctResult: Int, wrongResult: Int?) {
        answerButtons[correctResult].backgroundColor = .green
        var response: QuizQuestionResponse = .CORRECT
        if let wrongResult = wrongResult {
            answerButtons[wrongResult].backgroundColor = .red
            response = .INCORRECT
        }
        
        for (_, element) in answerButtons.enumerated() {
            element.isEnabled = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.presenter.advanceInQuestion(answer: response)
        }
    }
    
    func advanceInQuestion(result: QuizQuestionResponse, questionIndex: Int) {
        quizQuestion.setQuestion(index: questionIndex, quiz: quiz, correct: result)
        for (i, answer) in quiz.questions[questionIndex].answers.enumerated() {
            answerButtons[i].backgroundColor = .systemPurple
            answerButtons[i].setUp(title: answer,index: i)
            answerButtons[i].isEnabled = true
        }
    }
    
    func questionPublishError(result: ResponseCodeError) {
        switch result {
            case .badRequest:
                self.errorLabel.text = "One of the body params is not defined"
            case .unAuthorized:
                self.errorLabel.text = "Without token or token doesn't exist"
            case .notFound:
                self.errorLabel.text = "Quiz not found"
            case .forbidden:
                self.errorLabel.text = "Token doesn't exist for this 'user_id'"
            default:
                self.errorLabel.text = "Undefined error"
        }
    }
}
