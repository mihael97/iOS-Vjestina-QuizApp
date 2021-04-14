//
//  QuizCollection.swift
//  QuizApp
//
//  Created by five on 14/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuizCollection: UICollectionView {
    private let customCellIdentifier: String = "customCell"
    private var quizzes: [QuizCategory:[Quiz]] = [:]
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildView() {
        self.backgroundColor = .purple
        self.isHidden = true
        self.register(QuizThemeComponent.self, forCellWithReuseIdentifier: customCellIdentifier)
        self.dataSource = self
        self.delegate = self
    }
    
    
    public func update(quizzes:[QuizCategory:[Quiz]]) {
        self.quizzes = quizzes
        self.reloadData()
    }
    
    
}

extension QuizCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! QuizThemeComponent
        cell.setUp(quizzes: Array(quizzes)[indexPath.row].value)
        return cell
    }
  
}

extension QuizCollection: UICollectionViewDelegateFlowLayout   {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
}
