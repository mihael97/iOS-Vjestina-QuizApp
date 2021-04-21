//
//  NoQuizLoadedComponent.swift
//  QuizApp
//
//  Created by five on 14/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class NoQuizLoadedComponent: UIView {
    private var noLoadedQuizIcon: UIImageView!
    private var noLoadedQuizLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        noLoadedQuizLabel.translatesAutoresizingMaskIntoConstraints = false
        noLoadedQuizIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noLoadedQuizIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            noLoadedQuizIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            noLoadedQuizLabel.centerXAnchor.constraint(equalTo:self.centerXAnchor),
            noLoadedQuizLabel.topAnchor.constraint(equalTo: noLoadedQuizIcon.bottomAnchor, constant: 0.1*max(frame.width, frame.height))
        ])
    }
    
    private func buildView() {
        noLoadedQuizIcon = UIImageView()
        let configuration = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 50))
        noLoadedQuizIcon.image = UIImage(systemName: "xmark.circle", withConfiguration: configuration)?.withTintColor(.white)
    
        noLoadedQuizLabel = UILabel()
        noLoadedQuizLabel.text = "No quiz loaded"
        
        self.addSubview(noLoadedQuizIcon)
        self.addSubview(noLoadedQuizLabel)
    }
}
