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
    private var fetchQuizzesButton: UIButton!
    private var funFactLabel: FunFactLabel!
    private var quizCollection: QuizCollection!
    private var noLoadedQuizView: NoQuizLoadedComponent!
    private var quizzes: [QuizCategory:[Quiz]] = [:]
    private var router: AppRouterProtocol!
    private var networkManager: NetworkServiceProtocol!
    
    convenience init(router: AppRouterProtocol, networkManager: NetworkServiceProtocol) {
        self.init()
        self.router = router
        self.networkManager = networkManager
    }
    
    override func viewDidLoad() {
        buildView()
        setConstraints()
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
            fetchQuizzesButton.topAnchor.constraint(equalTo: quizNameLabel.bottomAnchor, constant: offset/2),
            fetchQuizzesButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            fetchQuizzesButton.widthAnchor.constraint(equalToConstant: 0.5*min(frame.width, frame.height)),
            funFactLabel.topAnchor.constraint(equalTo: fetchQuizzesButton.bottomAnchor, constant: offset/2),
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
        
        // Fetch quizzes button
        fetchQuizzesButton = UIButton()
        fetchQuizzesButton.setTitle("Get Quiz", for: .normal)
        fetchQuizzesButton.setTitleColor(.purple, for: .normal)
        fetchQuizzesButton.addTarget(self, action: #selector(self.fetchQuizzes), for: .touchUpInside)
        fetchQuizzesButton.backgroundColor = .white
        fetchQuizzesButton.layer.cornerRadius = 10
        
        // Fun fact label
        funFactLabel = FunFactLabel()
        funFactLabel.isHidden = true
                
        // No quiz loaded view
        noLoadedQuizView = NoQuizLoadedComponent()
        noLoadedQuizView.isHidden = false
        
        // Table
        quizCollection = QuizCollection(router: router)
         
        // Add to subview
        addSubview(subView: quizNameLabel)
        addSubview(subView: fetchQuizzesButton)
        addSubview(subView: funFactLabel)
        addSubview(subView: noLoadedQuizView)
        addSubview(subView: quizCollection)
    }
    
    private func addSubview(subView: UIView) {
        view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func findTitlesWithNBA(quizzes: [Quiz]) -> Int {
        return quizzes.map{ $0.questions.filter{ $0.question.uppercased().contains("NBA") }.count }.reduce(0, +)
    }

    @objc
    private func fetchQuizzes(button: UIButton) {
        networkManager.fetchQuizzes(completation: {response in
                DispatchQueue.main.async {
                    switch response {
                        case .failure:
                            self.noLoadedQuizView.isHidden = false
                        case .success(let arrayQuizzes):
                            self.quizzes = arrayQuizzes.reduce([:] as! [QuizCategory: [Quiz]], {
                                    a, b in
                                        var map:[QuizCategory: [Quiz]] = a
                                        var value = map[b.category,default: []]
                                        value.append(b)
                                        map[b.category] = value
                                        return map
                                }
                            )
                                    
                            self.funFactLabel.isHidden = false
                            self.funFactLabel.update(value: self.findTitlesWithNBA(quizzes: arrayQuizzes))
                            
                            self.quizCollection.isHidden = false
                            if !self.quizzes.isEmpty {
                                self.noLoadedQuizView.isHidden = true
                                self.quizCollection.update(quizzes: self.quizzes)
                            }
                    }
                }
            }
        )
                        
    }
}
