//
//  NetworkServiceProtocol.swift
//  QuizApp
//
//  Created by five on 10/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

struct LoginData:Codable{
    var token: String
    var usedId: Int
    
    enum LoginDataKeys: String, CodingKey {
        case token = "token"
        case userId = "user_id"
    }
}

class NetworkServiceProtocol {
    private let baseUrl: String = "iosquiz.herokuapp.com"
    private let userDefaults = UserDefaults.standard
    private let USER_ID_KEY: String = "user_id"
    private let API_TOKEN_KEY: String = "api_token"
    
    private func createComponent(path:String, params: [String:String?] = [String:String](), secure:Bool = true) -> URLComponents {
        var component = URLComponents()
        
        component.host = baseUrl
        component.path = path
        if secure {
            component.scheme = "https"
        } else {
            component.scheme = "http"
        }
        let queryParams: [URLQueryItem] = params.map {URLQueryItem(name: $0.key, value: $0.value)}
        component.queryItems = queryParams
        
        return component
    }
    
    func login(username:String, password:String, completation: @escaping(Result<Bool, RequestError>)->Void) -> Void {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var params = [String:String]()
        params["password"]=password
        params["username"]=username
        let component = createComponent(path: "/api/session", params: params)
        guard let url=component.url else {completation(.failure(.serverError)); return}

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = "POST"
        
        session.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                completation(.failure(.clientError))
                return
            }
            guard let data=data else {completation(.failure(.noDataError)); return}
            guard let response = response as? HTTPURLResponse else {completation(.failure(.serverError)); return;}
            if response.statusCode != 200 {
                completation(.failure(.serverError))
                return
            }
            guard let loginData:LoginData=try? JSONDecoder().decode(LoginData.self, from: data) else {completation(.failure(.decodingError)); return}
            
            self.userDefaults.set(loginData.token, forKey: self.API_TOKEN_KEY)
            self.userDefaults.set(loginData.usedId, forKey: self.USER_ID_KEY)
            
            completation(.success(true))
        }.resume()
    }
    
    func fetchLeaderboard(quizId: Int, completation: @escaping (_ response: [LeaderboardResult])->Void) -> Void  {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var params = [String:String]()
        params["query_id"]=String(quizId)
        let component = createComponent(path: "/api/score", params: params)
        guard let url=component.url else {completation([]); return}

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = "GET"
        
        session.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                completation([])
                return;
            }
            guard let response = response as? HTTPURLResponse else {completation([]); return;}
            if response.statusCode != 200 {
                completation([])
                return
            }
            guard let data=data else {completation([]);return;}
            guard let parsedData: [LeaderboardResult] = try? JSONDecoder().decode([LeaderboardResult].self, from: data) else {completation([]);return;}
            completation(parsedData)
        }.resume()
    }
        
    func fetchQuizzes(completation: @escaping (_ response: [Quiz])->Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let component = createComponent(path: "/api/quizzes")
        guard let url=component.url else {completation([]); return}

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = "GET"
        session.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                completation([])
                return
            }
            guard let response = response as? HTTPURLResponse else {completation([]); return}
            if response.statusCode != 200 {
                completation([])
                return
            }
            guard let data = data else {completation([]); return}
            guard let parsedData: [Quiz] = try? JSONDecoder().decode([Quiz].self, from: data) else {completation([]); return}
            completation(parsedData)
        }.resume()
    }
    
    func publishQuizResults(quizResult: QuizResult) {
        let session = URLSession(configuration: .default)
        let component = createComponent(path: "/api/result")
        guard let url = component.url else {return}
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: urlRequest) {
            (data, response, error) in
                if error != nil {
                    return
                }
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode != 200 {
                    return
                }
        }.resume()
    }
}
