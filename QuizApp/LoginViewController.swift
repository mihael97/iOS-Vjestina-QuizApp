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
    let radiusOfField = 5

    private var appNameLabel: UILabel!
    private var usernameTextField: UITextField!
    private var passwordField: UITextField!
    private var loginButton: UIButton!
    private var dataService: DataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataService = DataService()
        buildViews()
    }
    
    private func buildViews() {
        createViewComponents()
        styleView()
    }
    
    private func styleView() {
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            usernameTextField.widthAnchor.constraint(equalToConstant: 300),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordField.widthAnchor.constraint(equalToConstant: 300),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func createViewComponents() {
        view.backgroundColor = .purple

        // Quiz app Styling
        appNameLabel = UILabel()
        appNameLabel.text = "Quiz App"
        appNameLabel.font = UIFont(name:fontName, size: 50.0)
        appNameLabel.textColor = .systemYellow
        
        // Username field Styling
        usernameTextField = UITextField()
        usernameTextField.placeholder = "Email"
        usernameTextField.layer.cornerRadius = CGFloat(radiusOfField)
        usernameTextField.backgroundColor = .systemPurple
        usernameTextField.textColor = .black
        
        // Password field Styling
        passwordField = UITextField()
        passwordField.placeholder = "Password"
        passwordField.layer.cornerRadius = CGFloat(radiusOfField)
        passwordField.backgroundColor = .systemPurple
        usernameTextField.textColor = .black
        
        // Login button
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
        
        
        // Add layouts
        view.addSubview(appNameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
    }
    
   @objc func pressed(sender: UIButton!) {
    let response :LoginStatus = dataService.login(email: usernameTextField.text ?? "", password: passwordField.text ?? "")
    switch response {
    case .error(_,_):
        print("Failed failed with error")
        break
    case .success:
        print("Loggin is successfull")
    }
   }
}
