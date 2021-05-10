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
    private let fontName: String = "ArialRoundedMTBold"
    private let radiusOfField:Int64 = 5
    private let fieldsWidth  = CGFloat(300)
    private let fieldsHeight = CGFloat(40)
//    private let dataService: DataService = DataService()
    private let manager: NetworkServiceProtocol = NetworkServiceProtocol()
    private var router: AppRouterProtocol!

    private var appNameLabel: UILabel!
    private var usernameTextField: UITextField!
    private var passwordField: PasswordField!
    private var loginButton: UIButton!
    private var falseLoginLabel: UILabel!
    private var noConnectionView: NoInternetConnectionView!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let safeArea = view.safeAreaLayoutGuide
        let offset = 0.05*max(view.frame.height, view.frame.width)
        
        NSLayoutConstraint.activate([
            noConnectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            noConnectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
            noConnectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            noConnectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            appNameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            appNameLabel.topAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: -offset*3),
            falseLoginLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            falseLoginLabel.bottomAnchor.constraint(equalTo:usernameTextField.topAnchor ,constant: -offset/2),
            falseLoginLabel.widthAnchor.constraint(equalToConstant:  offset*5),
            usernameTextField.widthAnchor.constraint(equalToConstant: fieldsWidth),
            usernameTextField.heightAnchor.constraint(equalToConstant: fieldsHeight),
            usernameTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            passwordField.widthAnchor.constraint(equalToConstant: fieldsWidth),
            passwordField.heightAnchor.constraint(equalToConstant: fieldsHeight),
            passwordField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: offset/2),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: offset/2),
            loginButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: fieldsWidth),
            loginButton.heightAnchor.constraint(equalToConstant: fieldsHeight)
        ])
    }
    
    private func setRoundShape() {
        usernameTextField.layer.cornerRadius = CGFloat(radiusOfField)
        passwordField.layer.cornerRadius = CGFloat(radiusOfField)
        loginButton.layer.cornerRadius = CGFloat(radiusOfField)
    }
    
    private func buildView() {
        view.backgroundColor = .purple
        
        // No connection
        noConnectionView = NoInternetConnectionView()
        
        // Quiz app Styling
        appNameLabel = UILabel()
        appNameLabel.text = "Pop Quiz"
        appNameLabel.font = UIFont(name:fontName, size: 50.0)
        appNameLabel.textColor = .systemYellow
        
        // Username field Styling
        usernameTextField = UITextField()
        usernameTextField.placeholder = "Email"
        usernameTextField.layer.cornerRadius = CGFloat(radiusOfField)
        usernameTextField.backgroundColor = .systemPurple
        usernameTextField.textColor = .black
        usernameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        usernameTextField.autocapitalizationType = .none
        addDidChangeTrigger(element: usernameTextField)
        
        // Password field Styling
        passwordField = PasswordField()
        passwordField.backgroundColor = .systemPurple
        passwordField.textColor = .black
        addDidChangeTrigger(element: passwordField)
        
        // Login button
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemGray2
        loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
        loginButton.isHighlighted = false
        loginButton.setTitleColor(.purple, for: .normal)
        
        // False login label
        falseLoginLabel = UILabel()
        falseLoginLabel.textColor = .white
        falseLoginLabel.backgroundColor = .systemRed
        falseLoginLabel.text = "Wrong credentials"
        falseLoginLabel.textAlignment = .center
        falseLoginLabel.isHidden = true
        
        setRoundShape()
        
        // Add layouts
        addSubview(subView: appNameLabel)
        addSubview(subView: usernameTextField)
        addSubview(subView: passwordField)
        addSubview(subView: loginButton)
        addSubview(subView: falseLoginLabel)
        addSubview(subView: noConnectionView)
        
        setConnectionLayout(status: NetworkManager.networkManager.isInternetConnected())
    }
    
    private func setConnectionLayout(status: Bool) {
        appNameLabel.isHidden = !status
        usernameTextField.isHidden = !status
        passwordField.isHidden = !status
        loginButton.isHidden = !status
        noConnectionView.isHidden = status
        if !falseLoginLabel.isHidden {
            falseLoginLabel.isHidden = !status
        }
    }
    
    private func addSubview(subView: UIView) {
        view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addDidChangeTrigger(element: UITextField) {
        element.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc
    func login(sender: UIButton!) {
//        let response :LoginStatus = dataService.login(email: usernameTextField.text ?? "", password: passwordField.text ?? "")
//        switch response {
//            case .error(_,let message):
//                print("Loggin failed with error: \(message)")
//                falseLoginLabel.isHidden = false
//                break
//            case .success:
//
//                router.showTabBarController()
//        }
        print(passwordField.text ?? "")
        manager.login(username: usernameTextField.text ?? "", password: passwordField.text ?? "") { (response) in
            DispatchQueue.main.async {
                if response {
                    self.router.showTabBarController()
                } else {
                    self.falseLoginLabel.isHidden = false
                }
            }
        }
        
    }
    
    @objc
    func textFieldDidChange(_:UITextField)  {
        if(!falseLoginLabel.isHidden) {
            falseLoginLabel.isHidden = true
        }
        if(usernameTextField.text!.count != 0 && passwordField.text!.count != 0 ) {
            loginButton.backgroundColor = .white
        } else {
            loginButton.backgroundColor = .systemGray2
        }
    }
        
}

extension LoginViewController: NetworkManagerListener {
    func networkStatusChanged(status: Bool) {
        setConnectionLayout(status: status)
    }
}
