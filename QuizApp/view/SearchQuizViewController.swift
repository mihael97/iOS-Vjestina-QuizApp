//
//  SearchQuizViewController.swift
//  QuizApp
//
//  Created by five on 26/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class SearchQuizViewController: UIViewController {
    private var router: AppRouterProtocol!
    private var networkManager: NetworkServiceProtocol!
    private var searchBar: SearchBarView!
    private var quizCollection: QuizCollection!
    private var presenter: SearchBarViewPresenter!
    
    convenience init (router: AppRouterProtocol, networkManager: NetworkServiceProtocol) {
        self.init()
        self.router = router
        self.networkManager = networkManager
        self.presenter = SearchBarViewPresenter(networkManager: networkManager)
        self.presenter.setDelegate(delegate: self)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        setConstraints()
    }
    
    private func buildView() {
        self.view.backgroundColor = .purple
        searchBar = SearchBarView(presenter: self.presenter)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        quizCollection = QuizCollection(router: router)
        quizCollection.translatesAutoresizingMaskIntoConstraints = false
        quizCollection.isHidden = false
        view.addSubview(quizCollection)
    }
    
    private func setConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            searchBar.widthAnchor.constraint(equalToConstant: 300),
            searchBar.heightAnchor.constraint(equalToConstant: 30),
            searchBar.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            quizCollection.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            quizCollection.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            quizCollection.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10)
        ])
    }
}

extension SearchQuizViewController: SearchBarViewDelegate {
    func searchResults(quizzes: [QuizCategory : [Quiz]]) {
        quizCollection.update(quizzes: quizzes)
        quizCollection.isHidden = false
        quizCollection.reloadData()
    }
}
