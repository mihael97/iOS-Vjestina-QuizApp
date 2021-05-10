//
//  NetworkServiceProtocol.swift
//  QuizApp
//
//  Created by five on 10/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

class NetworkServiceProtocol {
    private let baseUrl: String = "iosquiz.herokuapp.com/api"
    
    func fetchLeaderboard(quizId: Int, completation: @escaping (_ response: [LeaderboardResult])->Void) -> Void  {
        completation(
        [
            LeaderboardResult(username: "a", score: "a"),
            LeaderboardResult(username: "b", score: nil)
        ]
        )
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//
//        var component = URLComponents()
//        component.host = baseUrl
//        component.scheme = "https"
//        component.path = "score"
//        component.queryItems = [
//            URLQueryItem(name: "query_id", value: String(quizId))
//        ]
//
//        guard let url=component.url else {return completation([])}
//
//        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
//        urlRequest.httpMethod = "GET"
//        session.dataTask(with: urlRequest) {
//            (data, response, error) in
//            if error != nil {
//                    return completation([])
//            } else if let data=data {
//                var parsedData: [LeaderboardResult] = []
//                do {
//                    parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [LeaderboardResult]
//                } catch {
//
//                }
//                return completation(parsedData)
//            }
//        }
    }
}
