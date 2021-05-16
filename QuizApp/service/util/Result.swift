//
//  Result.swift
//  QuizApp
//
//  Created by five on 12/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
/*Enum for HTTP response*/
enum Result<Success, Failure> where Failure : Error{
    case success(Success)
    case failure(Failure)
}
