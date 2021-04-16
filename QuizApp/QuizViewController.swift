//
//  QuizViewController.swift
//  QuizApp
//
//  Created by five on 16/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuizViewController: UIViewController {
    private let quiz:Quiz
    
    init(quiz:Quiz) {
        self.quiz=quiz
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        print("Quiz controller")
    }
}
