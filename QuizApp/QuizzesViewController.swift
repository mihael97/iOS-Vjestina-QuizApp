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
    private let numberOfQuizzesTemplate = "There are %d questions that contains the word \"NBA\""
    private var quizzes: [Quiz] = []
    let fontName = "ArialRoundedMTBold"
    
    override func viewDidLoad() {
        dataService = DataService()
        buildView()
        arangeOnScreen()
    }
    
    private func arangeOnScreen() {
        quizNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fetchQuizzesButton.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            quizNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quizNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            fetchQuizzesButton.topAnchor.constraint(equalTo: quizNameLabel.bottomAnchor, constant: 30),
            fetchQuizzesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchQuizzesButton.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        if (quizzes.count==0) {
            
        } else {
            funFactLabel.translatesAutoresizingMaskIntoConstraints = false
            numberOfQuizzesLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                funFactLabel.topAnchor.constraint(equalTo: fetchQuizzesButton.bottomAnchor, constant: 60),
                funFactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                numberOfQuizzesLabel.topAnchor.constraint(equalTo: funFactLabel.bottomAnchor, constant: 10),
                numberOfQuizzesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ])
        }
    }
    
    private func addTrailingBulb() {
        let largeFont = UIFont.systemFont(ofSize: 30)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)

        let image = UIImage(systemName: "lightbulb.fill", withConfiguration: configuration)
        
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
        quizNameLabel.text = "Quiz App"
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
        addTrailingBulb()
        
        // Number of quizzes label
        numberOfQuizzesLabel = UILabel()
        numberOfQuizzesLabel.font = UIFont(name: fontName, size: 20)
        numberOfQuizzesLabel.textColor = .white
        
        // Add to subview
        view.addSubview(quizNameLabel)
        view.addSubview(fetchQuizzesButton)
        view.addSubview(funFactLabel)
        view.addSubview(numberOfQuizzesLabel)
    }
    
    @objc
    private func fetchQuizzes(button: UIButton) {
        //quizzes = dataService.fetchQuizes().filter{ $0.title.uppercased().contains("NBA") }
        quizzes = dataService.fetchQuizes()
        numberOfQuizzesLabel.text = String(format: numberOfQuizzesTemplate, quizzes.count)
        numberOfQuizzesLabel.lineBreakMode = .byWordWrapping
        print("Fetch quizzes ",quizzes.count)
        arangeOnScreen()
    }
}
