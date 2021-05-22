//
//  SearchQuizViewController.swift
//  QuizApp
//
//  Created by five on 17/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class SearchQuizViewController: UIViewController  {
    private var networkManager: NetworkServiceProtocol!
    private var router: AppRouterProtocol!
    private var searchView: SearchBarView!
    
    convenience init(router: AppRouterProtocol, networkManager: NetworkServiceProtocol) {
        self.init()
        self.networkManager = networkManager
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        setConstraints()
    }
    
    private func buildView() {
        self.view.backgroundColor = .purple
        searchView = SearchBarView(router: router, networkManager: networkManager)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
}
