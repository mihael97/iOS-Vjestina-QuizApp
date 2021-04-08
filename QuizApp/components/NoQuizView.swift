//
//  NoQuizView.swift
//  QuizApp
//
//  Created by five on 08/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class NoQuizView: UIView {
    private var noQuizImage: UIImageView!
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
        noQuizLabel.translatesAutoresizingMaskIntoConstraints = false
        noQuizImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noQuizImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            noQuizImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            noQuizLabel.topAnchor.constraint(equalTo: noQuizImage.bottomAnchor, constant: 30),
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
        noQuizImage = UIImageView()
        let largeFont = UIFont.systemFont(ofSize: 50)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "xmark.circle", withConfiguration: configuration)?.withTintColor(.white)
        noQuizImage.image = image
        
        self.addSubview(noQuizImage)
        self.addSubview(noQuizLabel)
    }
}
