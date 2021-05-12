//
//  NetworkServiceProtocol.swift
//  QuizApp
//
//  Created by five on 10/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

struct LoginData: Codable {
    let token: String
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case token
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
            if response.statusCode != 201 {
                print(response.statusCode)
                completation(.failure(.serverError))
                return
            }
            
            guard let loginData: LoginData = try? JSONDecoder().decode(LoginData.self, from: data)  else   {completation(.failure(.decodingError)); return}
            self.userDefaults.set(loginData.token, forKey: self.API_TOKEN_KEY)
            self.userDefaults.set(loginData.userId, forKey: self.USER_ID_KEY)
    
            completation(.success(true))
        }.resume()
    }
    
    func fetchLeaderboard(quizId: Int, completation: @escaping (Result<[LeaderboardResult], RequestError>)->Void) -> Void  {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var params = [String:String]()
        params["query_id"]=String(quizId)
        let component = createComponent(path: "/api/score", params: params)
        guard let url=component.url else {completation(.failure(.serverError)); return}

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(userDefaults.string(forKey: API_TOKEN_KEY), forHTTPHeaderField: "Authorization")
        
        session.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                completation(.failure(.clientError))
                return;
            }
            guard let response = response as? HTTPURLResponse else {completation(.failure(.serverError)); return;}
            if response.statusCode != 200 {
                completation(.failure(.serverError))
                return
            }
            guard let data=data else {completation(.failure(.noDataError));return;}
            guard let parsedData: [LeaderboardResult] = try? JSONDecoder().decode([LeaderboardResult].self, from: data) else {completation(.failure(.decodingError));return;}
            completation(.success(parsedData))
        }.resume()
    }
        
    func fetchQuizzes(completation: @escaping (Result<[Quiz], RequestError>)->Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let component = createComponent(path: "/api/quizzes")
        guard let url=component.url else {completation(.failure(.serverError)); return}

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(userDefaults.string(forKey: API_TOKEN_KEY), forHTTPHeaderField: "Authorization")

        session.dataTask(with: urlRequest) {
            (data, response, error) in
            if error != nil {
                completation(.failure(.clientError))
                return
            }
            guard let response = response as? HTTPURLResponse else {completation(.failure(.serverError)); return}
            if response.statusCode != 200 {
                completation(.failure(.serverError))
                return
            }
            guard let data = data else {completation(.failure(.noDataError)); return}
            guard let parsedData: QuizzesDto = try? JSONDecoder().decode(QuizzesDto.self, from: data) else {completation(.failure(.decodingError));return}
            completation(.success(parsedData.quizzes))
        }.resume()
    }
    
    func publishQuizResults(quizId: Int, time: Double, numberOfCorrectAnswers: Int, completation: @escaping (Result<Bool, RequestError>)->Void) {
        let session = URLSession(configuration: .default)
        let component = createComponent(path: "/api/result")
        guard let url = component.url else {return}
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(userDefaults.string(forKey: API_TOKEN_KEY), forHTTPHeaderField: "Authorization")
                        
        let bodyJson: Dictionary<String, Any> = [
            "quiz_id": quizId,
            "user_id": userDefaults.integer(forKey: USER_ID_KEY),
            "time": time,
            "no_of_correct": numberOfCorrectAnswers
        ]
        guard let body = try? JSONSerialization.data(withJSONObject: bodyJson) else {completation(.failure(.clientError));return}
        urlRequest.httpBody = body
        
        session.dataTask(with: urlRequest) {
            (data, response, error) in
                if error != nil {
                    completation(.failure(.clientError))
                    return
                }
                guard let response = response as? HTTPURLResponse else {return}
                switch response.statusCode {
                    case 401:
                        completation(.failure(.clientError))
                    case 403:
                        completation(.failure(.clientError))
                    case 404:
                        completation(.failure(.clientError))
                    case 400:
                        completation(.failure(.clientError))
                    case 200:
                        completation(.success(true))
                    default:
                        completation(.failure(.clientError))
                }
        }.resume()
    }
}
