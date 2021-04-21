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
    weak public var controller: UIViewController?
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
        self.register(QuizTableCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        self.register(CustomSectionHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        self.dataSource = self
        self.delegate = self
    }
    
    
    public func update(quizzes:[QuizCategory:[Quiz]]) {
        self.quizzes = quizzes
        self.reloadData()
    }
    
}

extension QuizCollection: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return quizzes.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Array(quizzes)[section].value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! QuizTableCell
        cell.setUp(quiz: Array(quizzes)[indexPath.section].value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let collectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CustomSectionHeader
        
        collectionView.setUpHeader(header: Array(quizzes)[indexPath.section].key.rawValue)
        
        return collectionView
    }
  
}

extension QuizCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: self.frame.height*0.1)
    }
}
