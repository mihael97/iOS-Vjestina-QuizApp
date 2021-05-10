//
//  NoInternetConnectionView.swift
//  QuizApp
//
//  Created by five on 10/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class NoInternetConnectionView: UIView {
    private let fontName: String = "ArialRoundedMTBold"
    private var label: UILabel!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setContstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildView() {
        self.backgroundColor = .purple
        
        label = UILabel()
        label.text = "Provide internet connection"
        label.font = UIFont(name:fontName, size: 30)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .red
        addToSubiew(component: label)
    }
    
    private func addToSubiew(component: UIView) {
        self.addSubview(component)
        component.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setContstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
        ])
    }
}
