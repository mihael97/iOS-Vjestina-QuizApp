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
    private var funFactLabel: UILabel!
    private var numberOfQuizzesLabel: UILabel!
    private var quizCollection: UICollectionView!
    private var noQuizView: NoQuizView!
    private var quizzes: [QuizCategory:[Quiz]] = [:]
    private let fontName: String = "ArialRoundedMTBold"
    private let customCellIdentifier: String = "customCell"
    private let numberOfQuizzesTemplate: String = "There are %d questions that contains the word \"NBA\""
    
    override func viewDidLoad() {
        dataService = DataService()
        buildView()
        setConstraints()
    }
        
    private func setConstraints() {
        NSLayoutConstraint.activate([
            quizNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quizNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            fetchQuizzesButton.topAnchor.constraint(equalTo: quizNameLabel.bottomAnchor, constant: 30),
            fetchQuizzesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchQuizzesButton.widthAnchor.constraint(equalToConstant: 300),
            funFactLabel.topAnchor.constraint(equalTo: fetchQuizzesButton.bottomAnchor, constant: 60),
            funFactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            numberOfQuizzesLabel.topAnchor.constraint(equalTo: funFactLabel.bottomAnchor, constant: 10),
            numberOfQuizzesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            numberOfQuizzesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            noQuizView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noQuizView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quizCollection.topAnchor.constraint(equalTo: numberOfQuizzesLabel.bottomAnchor, constant: 20),
            quizCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            quizCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            quizCollection.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -10)
        ])
    }
    
    private func addTrailingBulb() {
        let largeFont = UIFont.systemFont(ofSize: 30)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)

        let image = UIImage(systemName: "lightbulb", withConfiguration: configuration)?.withTintColor(.yellow)
        
        let bulbAttachment = NSTextAttachment()
        bulbAttachment.image = image
        let attachmentString = NSAttributedString(attachment:  bulbAttachment)
        let string = NSMutableAttributedString(string: "", attributes: [:])
        string.append(attachmentString)
        if let labelValue = funFactLabel.text {
            string.append(NSMutableAttributedString(string: String(format:" %@",labelValue), attributes: [:]))
        }
        funFactLabel.attributedText = string
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
        funFactLabel = UILabel()
        funFactLabel.text = "Fun Fact"
        funFactLabel.textColor = .white
        funFactLabel.font = UIFont(name: fontName, size: 25)
        funFactLabel.isHidden = true
        addTrailingBulb()
        
        // Number of quizzes label
        numberOfQuizzesLabel = UILabel()
        numberOfQuizzesLabel.font = UIFont(name: fontName, size: 20)
        numberOfQuizzesLabel.textColor = .white
        numberOfQuizzesLabel.numberOfLines = 0
        numberOfQuizzesLabel.lineBreakMode = .byWordWrapping
                
        // No quiz view
        noQuizView = NoQuizView()
        
        // Table
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        quizCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        quizCollection.backgroundColor = .purple
        quizCollection.isHidden = true
        quizCollection.register(QuizThemeComponent.self, forCellWithReuseIdentifier: customCellIdentifier)
        quizCollection.dataSource = self
        quizCollection.delegate = self
         
        // Add to subview
        addSubview(subView: quizNameLabel)
        addSubview(subView: fetchQuizzesButton)
        addSubview(subView: funFactLabel)
        addSubview(subView: numberOfQuizzesLabel)
        addSubview(subView: noQuizView)
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
                
        noQuizView.isHidden = true
        funFactLabel.isHidden = false
        numberOfQuizzesLabel.text = String(format: numberOfQuizzesTemplate, findTitlesWithNBA(quizzes: arrayQuizzes))
        numberOfQuizzesLabel.numberOfLines = 0
        quizCollection.isHidden = false
        quizCollection.reloadData()
    }
}

extension QuizzesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! QuizThemeComponent
        cell.setUp(quizzes: Array(quizzes)[indexPath.row].value)
        return cell
    }
  
}

extension QuizzesViewController: UICollectionViewDelegateFlowLayout   {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
}
