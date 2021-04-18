//
//  AnswerButton.swift
//  QuizApp
//
//  Created by five on 18/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class AnswerButton: UIButton {
    private var index:Int=0
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildView() {
        self.backgroundColor = .systemPurple
        self.setTitleColor(.white, for: .normal)
    }
    
    public func setUp(title: String, index:Int) {
        self.setTitle(title, for: .normal)
        self.index=index
    }
    
    public func getIndex()->Int {
        return self.index
    }
}
