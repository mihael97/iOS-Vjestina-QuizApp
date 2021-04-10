//
//  PasswordField.swift
//  QuizApp
//
//  Created by five on 05/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import SwiftUI

class PasswordField: UITextField {
    private let radiusOfField:Int64 = 5
    private let offsetOfField:Int64 = 5
    private let openEyeImageName: UIImage? = UIImage(systemName: "eye")?.withTintColor(.black)
    private let closeEyeImageName: UIImage? = UIImage(systemName: "eye.slash")?.withTintColor(.black)
    
    private var passwordShowButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        setupField()
        addVisiblityButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupField() {
        self.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        self.isSecureTextEntry = true
        self.placeholder = "Password"
    }
        
    private func addVisiblityButton() {
        passwordShowButton = UIButton()
        passwordShowButton.setImage(openEyeImageName, for: .normal)
        passwordShowButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: -24, bottom: 5, right: 15)
        passwordShowButton.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(15), height: CGFloat(25))
        passwordShowButton.addTarget(self, action: #selector(self.visibilityButtonClicked), for: .touchUpInside)
        self.rightView = passwordShowButton
        self.rightViewMode = .always
        passwordShowButton.isHidden = true
    }
        
    @objc
    private func visibilityButtonClicked(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            passwordShowButton.setImage(closeEyeImageName, for: .normal)
        } else {
            passwordShowButton.setImage(openEyeImageName, for: .normal)
        }
        self.isSecureTextEntry = !self.isSecureTextEntry
    }
}

extension PasswordField:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        passwordShowButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        passwordShowButton.isHidden = true
    }
}
