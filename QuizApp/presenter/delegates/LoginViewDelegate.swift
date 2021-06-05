//
//  LoginViewDelegate.swift
//  QuizApp
//
//  Created by five on 14/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

protocol LoginViewDelegate: NSObjectProtocol {
    func loginResultError()
    func setConnectionLayout(status: Bool)
    func loginSuccessful()
}
