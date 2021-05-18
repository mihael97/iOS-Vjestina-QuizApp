//
//  QuestionCD+CoreDataProperties.swift
//  
//
//  Created by five on 18/05/2021.
//
//

import Foundation
import CoreData


extension QuestionCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionCD> {
        return NSFetchRequest<QuestionCD>(entityName: "QuestionCD")
    }

    @NSManaged public var answers: NSObject?
    @NSManaged public var correctAnswer: Int32
    @NSManaged public var idCD: Int32
    @NSManaged public var question: String?

}
