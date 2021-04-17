//
//  AnswerButton.swift
//  QuizApp
//
//  Created by five on 17/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class AnswerButton: UIButton {
    public var answerIndex:Int!
    override init(frame: CGRect) {
        super.init(frame:frame)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildView() {
        self.backgroundColor = .systemPurple
        self.layer.cornerRadius = CGFloat(15)
    }
    
    public func setUp(title:String, index:Int) {
        answerIndex=index
        self.setTitle(title, for: .normal)
    }
}
