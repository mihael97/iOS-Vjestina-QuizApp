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
    private var presenter: QuizResultPresenter!
    private var quizResultLabel: UILabel!
    private var quizId: Int!
    private var finishQuizButton:UIButton!
    private var leaderboardResults: UIButton!
    private var correctAnswers: Int!
    private var totalAnswers: Int!
        
    convenience init (quizId:Int, correct: Int, total: Int, router: AppRouterProtocol) {
        self.init()
        self.quizId = quizId
        self.correctAnswers=correct
        self.totalAnswers=total
        self.presenter = QuizResultPresenter(router: router)
    }
    
    override func viewDidLoad() {
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
    
    private func setConstraints() {
        quizResultLabel.translatesAutoresizingMaskIntoConstraints = false
        finishQuizButton.translatesAutoresizingMaskIntoConstraints = false
        leaderboardResults.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        let frame = view.frame
        
        NSLayoutConstraint.activate([
            quizResultLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            quizResultLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            leaderboardResults.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            leaderboardResults.bottomAnchor.constraint(equalTo: finishQuizButton.topAnchor, constant: -20),
            leaderboardResults.widthAnchor.constraint(equalToConstant: frame.width*0.8),
            finishQuizButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            finishQuizButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -frame.height*0.05),
            finishQuizButton.widthAnchor.constraint(equalToConstant: frame.width*0.8)
        ])
    }
    
    private func addButtonStyle(button: UIButton) {
        button.setTitleColor(.purple, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = CGFloat(10)
    }
    
    private func buildView() {
        view.backgroundColor = .purple
        quizResultLabel=UILabel()
        quizResultLabel.text="\(self.correctAnswers!) / \(self.totalAnswers!)"
        quizResultLabel.textColor = .white
        quizResultLabel.font = UIFont.boldSystemFont(ofSize: 50)
        
        finishQuizButton = UIButton()
        finishQuizButton.setTitle("Finish Quiz", for: .normal)
        addButtonStyle(button: finishQuizButton)
        finishQuizButton.addTarget(self, action: #selector(QuizResultViewController.navigate(_:)), for: .touchUpInside)
        
        leaderboardResults = UIButton()
        leaderboardResults.setTitle("See leaderboard", for: .normal)
        addButtonStyle(button: leaderboardResults)
        leaderboardResults.addTarget(self, action: #selector(QuizResultViewController.leaderBoard(_:)), for: .touchUpInside)
        
        view.addSubview(quizResultLabel)
        view.addSubview(finishQuizButton)
        view.addSubview(leaderboardResults)
    }
    
    @objc
    private func navigate(_ sender: UIButton) {
        presenter.showTabBarController()
    }
    
    @objc
    private func leaderBoard(_ sender: UIButton)  {
        presenter.showLeaderboard(quizId: quizId)
    }
}
