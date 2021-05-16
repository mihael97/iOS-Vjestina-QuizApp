//
//  RequestError.swift
//  QuizApp
//
//  Created by five on 12/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

/*Error types from backend*/
enum RequestError: Error {
    case clientError
    case serverError
    case noDataError
    case decodingError
}
