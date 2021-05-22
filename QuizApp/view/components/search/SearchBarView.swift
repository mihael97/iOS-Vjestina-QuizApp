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
    private let ICON_NAME: String = "magnifyingglass"
    private var searchField: UITextField!
    private var searchButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setRoundShape() {
        searchField.layer.cornerRadius = CGFloat(5)
    }
    
    private func buildView() {
        self.backgroundColor = .purple
        
        searchField = UITextField()
        searchField.backgroundColor = .systemPurple
        searchField.textColor = .black
        searchField.placeholder = "Type here"
        searchField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        addToSubview(element: searchField)
        
        searchButton = UIButton()
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(self.searchButtonClicked), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        addToSubview(element: searchButton)
        
        setRoundShape()
    }
    
    private func addToSubview(element: UIView) {
        element.translatesAutoresizingMaskIntoConstraints = false
        addSubview(element)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            searchField.widthAnchor.constraint(equalToConstant: 200),
            searchField.heightAnchor.constraint(equalToConstant: 40),
            searchButton.leadingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: 10),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc
    private func searchButtonClicked(button: UIButton!) {
        print("Clicked")
    }
}
