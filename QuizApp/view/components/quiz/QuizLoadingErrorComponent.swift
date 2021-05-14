//
//  NoQuizView.swift
//  QuizApp
//
//  Created by five on 08/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuizLoadingErrorComponent: UIView {
    private var noQuizIcon: UIImageView!
    private var noQuizLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        noQuizIcon.translatesAutoresizingMaskIntoConstraints = false
        noQuizLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noQuizIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            noQuizIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            noQuizLabel.topAnchor.constraint(equalTo: noQuizIcon.bottomAnchor, constant: 30),
            noQuizLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    private func buildView() {        
        // no quiz label
        noQuizLabel = UILabel()
        noQuizLabel.textAlignment = .center
        noQuizLabel.font = UIFont.systemFont(ofSize: CGFloat(20))
        noQuizLabel.numberOfLines = 0
        noQuizLabel.textColor = .white
        noQuizLabel.text = """
        Data can't be reached
        Please try again
        """
        
        // no quiz image
        noQuizIcon = UIImageView()
        let largeFont = UIFont.systemFont(ofSize: 50)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "xmark.circle", withConfiguration: configuration)?.withTintColor(.white)
        noQuizIcon.image = image
        
        self.addSubview(noQuizIcon)
        self.addSubview(noQuizLabel)
    }
}
