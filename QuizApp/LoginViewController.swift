//
//  LoginViewController.swift
//  QuizApp
//
//  Created by five on 02/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    let fontName = "ArialRoundedMTBold"
    
    private var appNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews() {
        createViewComponents()
        styleView()
    }
    
    private func styleView() {
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        ])
    }
    
    private func createViewComponents() {
        view.backgroundColor = .purple

        appNameLabel = UILabel()
        appNameLabel.text = "Quiz App"
        appNameLabel.font = UIFont(name:fontName, size: 50.0)
        appNameLabel.textColor = .systemYellow

        view.addSubview(appNameLabel)
    }
    
}
