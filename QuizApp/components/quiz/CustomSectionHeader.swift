//
//  CustomSectionHeader.swift
//  QuizApp
//
//  Created by five on 21/04/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class CustomSectionHeader: UICollectionReusableView {
    private var sectionHeader: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        sectionHeader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sectionHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            sectionHeader.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            sectionHeader.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            sectionHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
    
    private func buildView() {
        sectionHeader = UILabel()
        sectionHeader.backgroundColor = .purple
        sectionHeader.textColor = .yellow
        sectionHeader.font = UIFont.boldSystemFont(ofSize: 15)
        
        addSubview(sectionHeader)
    }
    
    public func setUpHeader(header: String) {
        sectionHeader.text = header
    }
}
