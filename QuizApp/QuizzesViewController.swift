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
    private var dataService: DataService!
    private var quizNameLabel: UILabel!
    private var fetchQuizzesButton: UIButton!
    private var funFactLabel: FunFactLabel!
    private var quizCollection: QuizCollection!
    private var noLoadedQuizView: NoQuizLoadedComponent!
    private var quizzes: [QuizCategory:[Quiz]] = [:]
    private let fontName: String = "ArialRoundedMTBold"
    
    override func viewDidLoad() {
        dataService = DataService()
        buildView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
        
    private func setConstraints() {
        NSLayoutConstraint.activate([
            quizNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quizNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            fetchQuizzesButton.topAnchor.constraint(equalTo: quizNameLabel.bottomAnchor, constant: 30),
            fetchQuizzesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchQuizzesButton.widthAnchor.constraint(equalToConstant: 300),
            funFactLabel.topAnchor.constraint(equalTo: fetchQuizzesButton.bottomAnchor, constant: 60),
            funFactLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            funFactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            noLoadedQuizView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noLoadedQuizView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quizCollection.topAnchor.constraint(equalTo: funFactLabel.bottomAnchor, constant: 20),
            quizCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            quizCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            quizCollection.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -10)
        ])
    }
    
    private func buildView() {
        view.backgroundColor = .purple
        navigationItem.hidesBackButton = true
        
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
        quizCollection = QuizCollection(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        quizCollection.controller=self
         
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
        let arrayQuizzes = dataService.fetchQuizes()
                        
        quizzes = arrayQuizzes.reduce([:] as! [QuizCategory: [Quiz]], {
                a, b in
                    var map:[QuizCategory: [Quiz]] = a
                    var value = map[b.category,default: []]
                    value.append(b)
                    map[b.category] = value
                    return map
            }
        )
                
        funFactLabel.isHidden = false
        funFactLabel.update(value: findTitlesWithNBA(quizzes: arrayQuizzes))
        
        quizCollection.isHidden = false
        if !quizzes.isEmpty {
            noLoadedQuizView.isHidden = true
            quizCollection.update(quizzes: quizzes)
        }
    }
}
