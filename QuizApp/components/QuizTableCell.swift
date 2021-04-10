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
    private var levelRating: LevelRating!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        buildView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        quizImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        levelRating.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            quizImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            quizImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            quizImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            quizImage.widthAnchor.constraint(equalToConstant: 100),
            quizImage.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.leadingAnchor.constraint(equalTo:quizImage.trailingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            levelRating.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            levelRating.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: quizImage.trailingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
        ])
    }
    
    private func setupCell() {
        self.backgroundColor = .systemPurple
    }
    
    private func buildView() {
        // title label
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        // image
        quizImage = UIImageView()
        
        //description label
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        
        //rating starts
        levelRating = LevelRating()
        
        self.addSubview(titleLabel)
        self.addSubview(quizImage)
        self.addSubview(descriptionLabel)
        self.addSubview(levelRating)
    }
    
    public func setUp(quiz:Quiz) {
        titleLabel.text = quiz.title
        descriptionLabel.text=quiz.description

        quizImage.image = UIImage(named: "download.jpeg")
        levelRating.setUp(rating: quiz.level)
        print(quiz.level)
    }
}
