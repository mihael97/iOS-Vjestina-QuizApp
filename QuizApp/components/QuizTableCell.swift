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
    private var descriptionLabel: UILabel!
    
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
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            quizImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            quizImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            quizImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            quizImage.widthAnchor.constraint(equalToConstant: 100),
            quizImage.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.leadingAnchor.constraint(equalTo:quizImage.trailingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: quizImage.trailingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
    func buildView() {
        self.backgroundColor = .systemPurple
        // title label
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        // image
        quizImage = UIImageView()
        
        //description label
        descriptionLabel = UILabel()
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        
        self.addSubview(titleLabel)
        self.addSubview(quizImage)
        self.addSubview(descriptionLabel)
    }
    
    public func setUp(quiz:Quiz) {
        titleLabel.text = quiz.title
        descriptionLabel.text=quiz.description

        quizImage.image = UIImage(named: "download.jpeg")
    }
}
