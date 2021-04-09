//
//  QuizTableCell.swift
//  QuizApp
//
//  Created by five on 03/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuizTableCell: UICollectionViewCell {
    private var titleLabel: UILabel!
    private var quizImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        quizImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            quizImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            quizImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            quizImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            titleLabel.trailingAnchor.constraint(equalTo: quizImage.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        ])
    }
    
    func buildView() {
        // title label
        titleLabel = UILabel()
        titleLabel.backgroundColor = .purple
        titleLabel.textColor = .white
        
        // image
        quizImage = UIImageView()
        
        self.addSubview(titleLabel)
        self.addSubview(quizImage)
    }
    
    public func setUp(quiz:Quiz) {
        titleLabel.text = quiz.title

        let url = URL(string: quiz.imageUrl)
        let data = try? Data(contentsOf: url!)
        quizImage.image = UIImage(data: data!)
    }
}
