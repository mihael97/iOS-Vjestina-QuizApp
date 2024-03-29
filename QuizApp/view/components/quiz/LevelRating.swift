//
//  LevelRating.swift
//  QuizApp
//
//  Created by five on 10/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class LevelRating: UIView {
    private let ICON_ACTIVE: String = "suit.diamond.fill"
    private var difficultyIcon: UIImageView!
    private var difficultyLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        difficultyIcon.translatesAutoresizingMaskIntoConstraints = false
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            difficultyIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            difficultyLabel.trailingAnchor.constraint(equalTo: difficultyIcon.leadingAnchor, constant: -2)
        ])
    }
    
    private func buildView() {
        difficultyLabel = UILabel()
        difficultyLabel.textColor = .white
        
        difficultyIcon = UIImageView()
        difficultyIcon.image = UIImage(systemName: ICON_ACTIVE)?.withTintColor(.yellow)
        
        self.addSubview(difficultyIcon)
        self.addSubview(difficultyLabel)
    }
    
    public func setUp(rating: Int) {
        difficultyLabel.text = String(rating)
    }
}

