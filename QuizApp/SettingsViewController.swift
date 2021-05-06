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
    private var router: AppRouterProtocol!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
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
        let width = max(view.frame.width*0.5, 200)
        let offset = 0.05*max(view.frame.width, view.frame.height)
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: offset),
            usernameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: offset),
            username.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: offset/2),
            username.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: offset),
            logOutButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            logOutButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -offset),
            logOutButton.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    private func buildView() {
        view.backgroundColor = .purple
        
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
        logOutButton.layer.cornerRadius = 10
        
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
        router.popToRoot()
    }
}
