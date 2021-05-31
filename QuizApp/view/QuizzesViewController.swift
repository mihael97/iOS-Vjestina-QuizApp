//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by five on 03/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuizzesViewController: UIViewController {
    private let fontName: String = "ArialRoundedMTBold"

    private var quizNameLabel: UILabel!
    private var funFactLabel: FunFactLabel!
    private var quizCollection: QuizCollection!
    private var noLoadedQuizView: NoQuizLoadedComponent!
    private var quizzes: [QuizCategory:[Quiz]] = [:]
    private var router: AppRouterProtocol!
    private var networkManager: NetworkServiceProtocol!
    private var presenter: QuizzesPresenter!
    
    convenience init(router: AppRouterProtocol, networkManager: NetworkServiceProtocol) {
        self.init()
        self.router = router
        self.presenter = QuizzesPresenter(router:router, networkManager: networkManager)
    }
    
    override func viewDidLoad() {
        self.presenter.setQuizzesViewDelegate(delegate: self)
        buildView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchQuizzes()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
            
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let frame = view.frame
        let offset = 0.05*max(frame.height, frame.width)
        
        NSLayoutConstraint.activate([
            quizNameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            quizNameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: offset/2),
            funFactLabel.topAnchor.constraint(equalTo: quizNameLabel.bottomAnchor, constant: offset/2),
            funFactLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -offset),
            funFactLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: offset),
            noLoadedQuizView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            noLoadedQuizView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            quizCollection.topAnchor.constraint(equalTo: funFactLabel.bottomAnchor, constant: offset),
            quizCollection.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: offset),
            quizCollection.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -offset),
            quizCollection.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -offset)
        ])
    }
    
    private func buildView() {
        view.backgroundColor = .purple
        
        // Quiz name label
        quizNameLabel = UILabel()
        quizNameLabel.text = "Pop Quiz"
        quizNameLabel.font = UIFont(name:fontName, size: 50.0)
        quizNameLabel.textColor = .systemYellow
        
        // Fun fact label
        funFactLabel = FunFactLabel()
        funFactLabel.isHidden = true
                
        // No quiz loaded view
        noLoadedQuizView = NoQuizLoadedComponent()
        noLoadedQuizView.isHidden = false
        
        // Table
        quizCollection = QuizCollection(presenter: presenter)
         
        // Add to subview
        addSubview(subView: quizNameLabel)
        addSubview(subView: funFactLabel)
        addSubview(subView: noLoadedQuizView)
        addSubview(subView: quizCollection)
    }
    
    private func addSubview(subView: UIView) {
        view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func findTitlesWithNBA(mapQuizzes: [QuizCategory:[Quiz]]) -> Int {
        var sum=0
        for item in mapQuizzes {
            sum+=item.value.map{ $0.questions.filter{ $0.question.uppercased().contains("NBA") }.count }.reduce(0, +)
        }
        return sum
    }

    @objc
    private func fetchQuizzes(button: UIButton) {
        presenter.fetchQuizzes()
    }
}

extension QuizzesViewController: QuizzesViewDelegate {
    
    func getQuizzes(quizzes: [QuizCategory:[Quiz]]) {
        if quizzes.count == 0 {
            self.noLoadedQuizView.isHidden = false
        } else {
            self.quizzes = quizzes
                    
            self.funFactLabel.isHidden = false
            self.funFactLabel.update(value: self.findTitlesWithNBA(mapQuizzes: quizzes))
            
            self.quizCollection.isHidden = false
            if !self.quizzes.isEmpty {
                self.noLoadedQuizView.isHidden = true
                self.quizCollection.update(quizzes: self.quizzes)
            }
        }
    }
    
}
