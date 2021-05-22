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
    private var searchView: SearchBarView!
    
    convenience init(networkManager: NetworkServiceProtocol) {
        self.init()
        self.networkManager = networkManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        setConstraints()
    }
    
    private func buildView() {
        self.view.backgroundColor = .purple
        searchView = SearchBarView()
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
