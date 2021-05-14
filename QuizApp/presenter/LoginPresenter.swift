//
//  LoginPresenter.swift
//  QuizApp
//
//  Created by five on 14/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation


class LoginPresenter {
    private let networkManager: NetworkServiceProtocol
    weak private var loginDelegate: LoginViewDelegate?
    
    init(networkManager: NetworkServiceProtocol) {
        self.networkManager = networkManager
        NetworkManager.networkManager.addObserver(observer: self)
    }
    
    func setViewDelegate(delegate: LoginViewDelegate) {
        self.loginDelegate = delegate
    }
    
    func login(username: String, password:String) {
        networkManager.login(username: username, password: password) { (response) in
                switch response {
                    case .failure:
                        self.loginDelegate?.loginResult(result: false)
                    case .success:
                        self.loginDelegate?.loginResult(result: true)
                }
        }
    }
    
    func getNetworkStatus() {
        loginDelegate?.setConnectionLayout(status: NetworkManager.networkManager.isInternetConnected())
    }
}

extension LoginPresenter: NetworkManagerListener {
    func networkStatusChanged(status: Bool) {
        loginDelegate?.setConnectionLayout(status: status)
    }
}
