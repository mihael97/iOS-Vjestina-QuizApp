//
//  SearchBarView.swift
//  QuizApp
//
//  Created by five on 17/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class SearchBarView: UIView {
    private var searchButton: UIButton!
    private var a: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildView() {
        self.backgroundColor = .purple
        
        searchButton = UIButton()
        searchButton.backgroundColor = .blue
        searchButton.setTitle("Search", for: .normal)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchButton)
        
        a = UIButton()
        a.backgroundColor = .white
        a.setTitle("Search", for: .normal)
        a.translatesAutoresizingMaskIntoConstraints = false
        addSubview(a)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchButton.widthAnchor.constraint(equalToConstant: 300),
            a.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 20)
        ])
    }
}
