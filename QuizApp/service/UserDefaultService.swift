//
//  UserDefaultService.swift
//  QuizApp
//
//  Created by five on 25/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation


class UserDefaultsService {
    private static let userDefaults: UserDefaults = UserDefaults.standard
    
    func setValue<T>(key:String, value:T) {
        UserDefaultsService.userDefaults.set(value, forKey: key)
    }
    
    func getStringValue(key:String) -> String? {
        return UserDefaultsService.userDefaults.string(forKey: key)
    }
    
    func getIntValue(key:String) -> Int {
        return UserDefaultsService.userDefaults.integer(forKey: key)
    }
}
