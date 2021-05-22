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
    private var router: AppRouterProtocol!
    private var searchField: UITextField!
    private var searchButton: UIButton!
    private var quizCollection: QuizCollection!
    private var presenter: SearchBarViewPresenter!
    
    convenience init(router: AppRouterProtocol, networkManager: NetworkServiceProtocol) {
        self.init(frame: .zero)
        self.router = router
        self.presenter = SearchBarViewPresenter(networkManager: networkManager)
        self.presenter.setDelegate(delegate: self)
        buildView()
        setConstraints()
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
        
        quizCollection = QuizCollection(router: self.router)
        addToSubview(element: quizCollection)
        
        setRoundShape()
    }
    
    private func addToSubview(element: UIView) {
        element.translatesAutoresizingMaskIntoConstraints = false
        addSubview(element)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            searchField.widthAnchor.constraint(equalToConstant: 200),
            searchField.heightAnchor.constraint(equalToConstant: 40),
            searchButton.leadingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: 10),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            quizCollection.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10),
            quizCollection.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    @objc
    private func searchButtonClicked(button: UIButton!) {
        self.presenter.fetchQuizzes(searchText: searchField.text!)
    }
}

extension SearchBarView: SearchBarViewDelegate {
    func searchResults(quizzes: [QuizCategory : [Quiz]]) {
        self.quizCollection.update(quizzes: quizzes)
    }
}
