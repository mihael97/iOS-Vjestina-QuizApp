//
//  QuizThemeComponent.swift
//  QuizApp
//
//  Created by five on 09/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class QuizThemeComponent: UICollectionViewCell {
    private var quizThemeLabel:UILabel!
    private var quizzes: [Quiz] = []
    private var quizCollection:UICollectionView!
    private let cellId = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        quizThemeLabel.translatesAutoresizingMaskIntoConstraints = false
        quizCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quizThemeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            quizThemeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            quizCollection.topAnchor.constraint(equalTo: quizThemeLabel.bottomAnchor, constant: 20),
            quizCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            quizCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            quizCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    private func buildView() {
        quizThemeLabel = UILabel()
        quizThemeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        quizThemeLabel.textColor = .yellow
        
        quizCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        quizCollection.register(QuizTableCell.self, forCellWithReuseIdentifier: cellId)
        quizCollection.dataSource = self
        quizCollection.delegate = self
        
        self.addSubview(quizThemeLabel)
        self.addSubview(quizCollection)
    }
    
    public func setUp(quizzes: [Quiz]) {
        if (quizzes.count==0) {
            return
        }
        switch quizzes[0].category {
        case .science:
            quizThemeLabel.text = "Science"
        case .sport:
            quizThemeLabel.text = "Sport"
        }
        self.quizzes = quizzes
    }
}

extension QuizThemeComponent:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! QuizTableCell
        cell.setUp(quiz: quizzes[indexPath.row])
        return cell
    }
}

extension QuizThemeComponent:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: quizCollection.frame.width, height: 100)
    }
}
