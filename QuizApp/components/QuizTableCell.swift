//
//  QuizTableCell.swift
//  QuizApp
//
//  Created by five on 03/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuizTableCell: UITableViewCell {
    var quiz: Quiz?
    private var titleLabel: UILabel!
    private var imageUI: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        if let quizImage = imageUI {
            quizImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                quizImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        }
    }
    
    func buildView() {
        if let quiz = quiz {
            // title label
            titleLabel = UILabel()
            titleLabel.text = quiz.title
            titleLabel.backgroundColor = .purple
            titleLabel.textColor = .white
            
            // image
            imageUI = UIImageView()
            let url = URL(string: quiz.imageUrl)
            let data = try? Data(contentsOf: url!)
            imageUI.image = UIImage(data: data!)
        }
    }
}
