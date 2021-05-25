//
//  LeaderboardViewContreoller.swift
//  QuizApp
//
//  Created by five on 10/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardViewController: UIViewController {
    private let cellId: String = "cellId"
    private let networkService: NetworkServiceProtocol = NetworkServiceProtocol()
    private var quizId: Int!
    private var router: AppRouterProtocol!
    private var results: [LeaderboardResult] = []
    private var table: UITableView!
    
    convenience init (quizId: Int, router: AppRouterProtocol) {
        self.init()
        self.router = router
        self.quizId = quizId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        setConstraints()
        fetchData()
    }
    
    private func fetchData() {
        networkService.fetchLeaderboard(quizId: 1, completation: {response in
            switch response {
                case .success(let data):
                    self.results = data
                    self.table.reloadData()
                case .failure(_):
                    print("Error")
            }
        })
    }
    
    private func buildView() {
        table = UITableView()
        self.view.addSubview(table)
        
        self.table.dataSource = self
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func setConstraints() {
        table.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            table.centerXAnchor.constraint(equalTo: table.centerXAnchor, constant: 0),
            table.centerYAnchor.constraint(equalTo: table.centerYAnchor, constant: 0)
        ])
    }
}

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell
    }
}
