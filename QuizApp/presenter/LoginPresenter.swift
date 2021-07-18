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
    private let router: AppRouterProtocol
    weak private var loginDelegate: LoginViewDelegate?
    
    init(networkManager: NetworkServiceProtocol, router: AppRouterProtocol) {
        self.networkManager = networkManager
        self.router = router
        NetworkManager.networkManager.addObserver(observer: self)
    }
    
    deinit {
        loginDelegate = nil
    }
    
    func setViewDelegate(delegate: LoginViewDelegate) {
        self.loginDelegate = delegate
    }
    
    func login(username: String, password:String) {
        networkManager.login(username: username, password: password) { [weak self](response) in
                guard let self=self else{return}
                switch response {
                    case .failure:
                        self.loginDelegate?.loginResultError()
                    case .success:
                        self.loginDelegate?.loginSuccessful()
                }
        }
    }
    
    func moveToQuizzes() {
        DispatchQueue.main.async {
            self.router.showTabBarController()
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
