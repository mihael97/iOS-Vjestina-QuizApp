//
//  LeaderboardHeaderCell.swift
//  QuizApp
//
//  Created by five on 12/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardHeaderCell: UITableViewCell {
    private var nameCell: UILabel!
    private var scoreCell: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        setConstraints()
    }
    
    private func setConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            nameCell.leadingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 20),
            scoreCell.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
        ])
    }
    
    private func buildView() {
        nameCell = UILabel()
        nameCell.text = "Player"
        addSubview(nameCell)
        
        scoreCell = UILabel()
        scoreCell.text = "Score"
        addSubview(scoreCell)
    }
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
