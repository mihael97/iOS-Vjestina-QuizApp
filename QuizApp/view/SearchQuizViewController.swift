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
    
    convenience init (router: AppRouterProtocol, networkManager: NetworkServiceProtocol) {
        self.init()
        self.router = router
        self.networkManager = networkManager
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        setConstraints()
    }
    
    private func buildView() {
        self.view.backgroundColor = .purple
        searchBar = SearchBarView()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
    }
    
    private func setConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            searchBar.widthAnchor.constraint(equalToConstant: 300),
            searchBar.heightAnchor.constraint(equalToConstant: 30),
            searchBar.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
        ])
    }
}
