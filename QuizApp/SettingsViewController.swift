//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by five on 20/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    private var usernameLabel: UILabel!
    private var username: UILabel!
    private var logOutButton: UIButton!
    
    override func viewDidLoad() {
        buildView()
        setConstraints()
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            username.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            username.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10)
        ])
    }
    
    private func buildView() {
        usernameLabel = UILabel()
        usernameLabel.textColor = .white
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        usernameLabel.text = "USERNAME: "
        
        username = UILabel()
        username.textColor = .white
        username.font = UIFont.systemFont(ofSize: 25)
        username.text = "SportJunkie1234"
        
        logOutButton = UIButton()
        logOutButton.backgroundColor = .white
        logOutButton.setTitleColor(.red, for: .normal)
        logOutButton.setTitle("Log out", for: .normal)
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        
        addSubview(element: usernameLabel)
        addSubview(element: username)
        addSubview(element: logOutButton)
    }
    
    private func addSubview(element: UIView) {
        element.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(element)
    }
    
    @objc
    private func logOut(_:UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
