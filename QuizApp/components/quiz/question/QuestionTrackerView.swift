//
//  ProgressBar.swift
//  QuizApp
//
//  Created by five on 25/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuestionTrackerView: UIView {
    private let animationKey = "progressAnimation"
    private var shapeLayer: CAShapeLayer!
    private var offsetBetweenBlocks: Float = 0
    private var blockWidth: Float = 0
    private var numberOfQuestions: Int = 0
    private var progressRectangles: [UIView] = []
        
    private func buildView() {
        for _ in 0...numberOfQuestions {
            let rectangle = UIView()
            rectangle.layer.cornerRadius = 5
            rectangle.backgroundColor = .gray
            progressRectangles.append(rectangle)
            
            rectangle.translatesAutoresizingMaskIntoConstraints = false
            addSubview(rectangle)
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        setSizes(numberOfQuestions: self.numberOfQuestions)
        setConstraints()
    }
        
    private func setConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        for (i, element) in progressRectangles.enumerated() {
            var constraints: [NSLayoutConstraint] = []
            if i != 0 {
                constraints.append(element.leadingAnchor.constraint(equalTo: progressRectangles[i-1].trailingAnchor, constant: CGFloat(offsetBetweenBlocks)))
            }
            
            constraints.append(contentsOf: [
                element.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
                element.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
            ])
            
            constraints.append(element.widthAnchor.constraint(equalToConstant: CGFloat(blockWidth)))
            constraints.append(element.heightAnchor.constraint(equalToConstant: CGFloat(max(blockWidth/30, 5))))
            
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    private func setSizes(numberOfQuestions: Int) {
        self.numberOfQuestions = numberOfQuestions
        
        var width: CGFloat = -1
        if self.frame.width < self.frame.height {
            width = UIScreen.main.bounds.height
        } else {
            width = UIScreen.main.bounds.width
        }

        offsetBetweenBlocks = Float(width)*0.2 / Float(numberOfQuestions-1)
        blockWidth = Float(width)*0.7 / Float(numberOfQuestions)
    }
    
    public func setUp(numberOfQuestions: Int) {
        setSizes(numberOfQuestions: numberOfQuestions)
        buildView()
        setConstraints()
    }
    
    public func updateQuestion(index: Int, correct: QuizQuestionResponse) {
        if correct != .EMPTY {
            if correct == .CORRECT {
                progressRectangles[index].backgroundColor = .green
            } else {
                progressRectangles[index].backgroundColor = .red
            }
        }
        
        if (index+1) < numberOfQuestions {
            progressRectangles[index+1].backgroundColor = .white
        }
    }
    
}
