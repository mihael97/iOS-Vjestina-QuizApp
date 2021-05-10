//
//  NetworkServiceProtocol.swift
//  QuizApp
//
//  Created by five on 10/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

struct LoginData {
    var token: String
    var user_id: Int
}

class NetworkServiceProtocol {
    private let baseUrl: String = "iosquiz.herokuapp.com"
    
    private func createComponent(path:String, params: [String:String?]) -> URLComponents {
        var component = URLComponents()
        
        component.host = baseUrl
        component.path = path
        component.scheme = "https"
        var queryParams: [URLQueryItem] = []
        for (key, value) in params {
            queryParams.append(URLQueryItem(name: key, value: value))
        }
        component.queryItems = queryParams
        
        return component
    }
    
    func login(username:String, password:String, completation: @escaping(_ response: Bool)->Void) -> Void {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var params = [String:String]()
        params["password"]=password
        params["username"]=username
        let component = createComponent(path: "/api/session", params: params)
        guard let url=component.url else {return completation(false)}

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = "POST"
        session.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                    return completation(false)
            } else if let data=data {
                do {
                    let data:[String : Any]=try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
                    if data["errors"] != nil {
                        return completation(false)
                    }
                } catch {
                    return completation(false)
                }
                return completation(true)
            }
        }.resume()
    }
    
    func fetchLeaderboard(quizId: Int, completation: @escaping (_ response: [LeaderboardResult])->Void) -> Void  {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var params = [String:String]()
        params["query_id"]=String(quizId)
        let component = createComponent(path: "/api/score", params: params)
        guard let url=component.url else {return completation([])}

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = "GET"
        session.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                    return completation([])
            } else if let data=data {
                var parsedData: [LeaderboardResult] = []
                do {
                    parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [LeaderboardResult]
                } catch {

                }
                return completation(parsedData)
            }
        }.resume()
    }
    
    func fetchQuizzes(completation: @escaping (_ response: [Quiz])->Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let component = createComponent(path: "/api/quizzes", params: [String:String]())
        guard let url=component.url else {return completation([])}

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = "GET"
        session.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                    return completation([])
            } else if let data=data {
                var parsedData: [Quiz] = []
                do {
                    parsedData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [Quiz]
                } catch {

                }
                return completation(parsedData)
            }
        }.resume()
    }
}
