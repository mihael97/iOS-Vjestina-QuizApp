//
//  QuizResultViewController.swift
//  QuizApp
//
//  Created by five on 18/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuizResultViewController: UIViewController {
    private var quizResultLabel: UILabel!
    private var finishQuizButton:UIButton!
    private let correctAnswers: Int
    private let totalAnswers: Int
    
    init(correct: Int, total: Int) {
        self.correctAnswers=correct
        self.totalAnswers=total
        super.init(nibName: nil, bundle: nil)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        quizResultLabel.translatesAutoresizingMaskIntoConstraints = false
        finishQuizButton.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        let frame = view.frame
        
        NSLayoutConstraint.activate([
            quizResultLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            quizResultLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            finishQuizButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            finishQuizButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -frame.height*0.05),
            finishQuizButton.widthAnchor.constraint(equalToConstant: frame.width*0.8)
        ])
    }
    
    private func buildView() {
        view.backgroundColor = .purple
        quizResultLabel=UILabel()
        quizResultLabel.text="\(self.correctAnswers) / \(self.totalAnswers)"
        quizResultLabel.textColor = .white
        quizResultLabel.font = UIFont.boldSystemFont(ofSize: 50)
        
        finishQuizButton = UIButton()
        finishQuizButton.setTitle("Finish Quiz", for: .normal)
        finishQuizButton.setTitleColor(.purple, for: .normal)
        finishQuizButton.backgroundColor = .white
        finishQuizButton.addTarget(self, action: #selector(QuizResultViewController.navigate(_:)), for: .touchUpInside)
        finishQuizButton.layer.cornerRadius = CGFloat(10)
        
        view.addSubview(quizResultLabel)
        view.addSubview(finishQuizButton)
    }
    
    @objc
    private func navigate(_ sender: UIButton) {
        self.navigationController?.pushViewController(TabBarController(), animated: true)
    }
}
