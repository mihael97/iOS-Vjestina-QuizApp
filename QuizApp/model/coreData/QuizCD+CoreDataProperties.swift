//
//  QuizCD+CoreDataProperties.swift
//  
//
//  Created by five on 18/05/2021.
//
//

import Foundation
import CoreData


extension QuizCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuizCD> {
        return NSFetchRequest<QuizCD>(entityName: "QuizCD")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var quizDescription: String?
    @NSManaged public var category: String?
    @NSManaged public var level: Int64
    @NSManaged public var imageUrl: String?
    @NSManaged public var relationship: QuestionCD?

}
