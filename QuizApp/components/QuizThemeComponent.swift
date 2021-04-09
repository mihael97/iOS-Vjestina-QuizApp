//
//  QuizThemeComponent.swift
//  QuizApp
//
//  Created by five on 09/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuizThemeComponent: UICollectionViewCell {
    private var quizThemeLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        quizThemeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quizThemeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            quizThemeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
        ])
    }
    
    private func buildView() {
        quizThemeLabel = UILabel()
        quizThemeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        quizThemeLabel.textColor = .yellow
        self.addSubview(quizThemeLabel)
    }
    
    public func setUp(quizzes: [Quiz]) {
        if (quizzes.count==0) {
            return
        }
        switch quizzes[0].category {
        case .science:
            quizThemeLabel.text = "Science"
        case .sport:
            quizThemeLabel.text = "Sport"
        }
    }
}
