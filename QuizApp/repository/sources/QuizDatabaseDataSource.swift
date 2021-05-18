//
//  QuizDatabaseDataSource.swift
//  QuizApp
//
//  Created by five on 17/05/2021.
//  Copyright © 2021 five. All rights reserved.
//

import Foundation
import CoreData

class QuizDatabaseDataSource {
    private let coreDataStack: CoreDataStack
    
    init() {
        self.coreDataStack = CoreDataStack()
    }
    
    private func convertToQuizzes(quizzes: [QuizCD]) -> [Quiz]{
        var coverted: [Quiz] = []
        
        for quiz in quizzes {
            var questions: [Question] = []
            for q in Array(quiz.questions!) as! [QuestionCD] {
                questions.append(Question(id: Int(q.idCD), question: q.question!, answers: q.answers! as! [String], correctAnswer: Int(q.correctAnswer)))
            }
            coverted.append(Quiz(id: Int(quiz.idCD), title: quiz.title!, description: quiz.descriptionCd!, category: QuizCategory(rawValue: quiz.category!)!, level: Int(quiz.level), imageUrl: quiz.imageUrl!, questions: questions))
        }
        
        return coverted
    }
    
    func fetchQuizzes() -> [Quiz] {
        let request: NSFetchRequest<QuizCD> = QuizCD.fetchRequest()
        let managedContext = coreDataStack.persistentContainer.viewContext
        do {
            let results = try managedContext.fetch(request)
            return convertToQuizzes(quizzes: results)
        } catch let error as NSError {
            print("Error \(error) | Info: \(error.userInfo)")
        }
        return []
    }
    
    private func saveQuiz(quiz: Quiz) {
        let managedContext = coreDataStack.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "QuizCD", in: managedContext)!
        let cdQuiz = QuizCD(entity: entity, insertInto: managedContext)
        cdQuiz.idCD = Int32(quiz.id)
        cdQuiz.category = quiz.category.rawValue
        cdQuiz.imageUrl = quiz.imageUrl
        cdQuiz.level = Int32(quiz.level)
        cdQuiz.descriptionCd = quiz.description
        cdQuiz.title = quiz.title
        try? managedContext.save()
    }
    
    private func updateQuiz(quizCd: QuizCD, quiz: Quiz) {
        let managedContext = coreDataStack.persistentContainer.viewContext
        quizCd.idCD = Int32(quiz.id)
        quizCd.category = quiz.category.rawValue
        quizCd.imageUrl = quiz.imageUrl
        quizCd.level = Int32(quiz.level)
        quizCd.descriptionCd = quiz.description
        quizCd.title = quiz.title
        try? managedContext.save()
    }
    
    func refreshQuizzes(quizzes: [Quiz]) {
        let managedContext = coreDataStack.persistentContainer.viewContext

        for quiz in quizzes {
            let request: NSFetchRequest<QuizCD> = QuizCD.fetchRequest()
            let predicate = NSPredicate(format: "ANY idCD=%@", "\(quiz.id)")
            request.predicate = predicate
            do {
                let fetchedQuizzes: [QuizCD] = try managedContext.fetch(request)
                if fetchedQuizzes.count == 0 {
                    saveQuiz(quiz: quiz)
                } else {
                    updateQuiz(quizCd: fetchedQuizzes[0], quiz: quiz)
                }
            } catch (let error) {
                fatalError("Fatal error: \(error.localizedDescription)")
            }
        }
    }
}
