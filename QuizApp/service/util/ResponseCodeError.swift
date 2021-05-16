//
//  ResponseCodeError.swift
//  QuizApp
//
//  Created by five on 14/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation

enum ResponseCodeError: Error {
    case unAuthorized
    case forbidden
    case notFound
    case badRequest
    case clientError
    case serverError
}
