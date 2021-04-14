//
//  FunFactLabel.swift
//  QuizApp
//
//  Created by five on 14/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class FunFactLabel: UIView {
    private let fontName: String = "ArialRoundedMTBold"
    private let numberOfQuizzesTemplate: String = "There are %d questions that contains the word \"NBA\""

    private var headerLabel: UILabel!
    private var factLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTrailingBulb() {
        let largeFont = UIFont.systemFont(ofSize: 30)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)

        let image = UIImage(systemName: "lightbulb", withConfiguration: configuration)?.withTintColor(.yellow)
        
        let bulbAttachment = NSTextAttachment()
        bulbAttachment.image = image
        let attachmentString = NSAttributedString(attachment:  bulbAttachment)
        let string = NSMutableAttributedString(string: "", attributes: [:])
        string.append(attachmentString)
        string.append(NSMutableAttributedString(string: String(format:" %@",headerLabel.text ?? ""), attributes: [:]))
        headerLabel.attributedText = string
    }
    
    private func setConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        factLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            factLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            factLabel.bottomAnchor.constraint(equalTo:self.bottomAnchor, constant: 0),
            factLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            factLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
        ])
    }
    
    private func buildView() {
        headerLabel = UILabel()
        headerLabel.text = "Fun Fact"
        headerLabel.textColor = .white
        headerLabel.font = UIFont(name: fontName, size: 25)
        addTrailingBulb()
        
        factLabel = UILabel()
        factLabel.font = UIFont(name: fontName, size: 20)
        factLabel.textColor = .white

        self.addSubview(headerLabel)
        self.addSubview(factLabel)
    }
    
    public func update(value:Int) {
        factLabel.text = String(format: numberOfQuizzesTemplate, value)
        factLabel.numberOfLines = 0
        factLabel.lineBreakMode = .byWordWrapping
    }

}
