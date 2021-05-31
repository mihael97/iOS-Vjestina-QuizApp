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
                questions.append(Question(id: Int(q.idCD), question: q.question!, answers: q.answers! , correctAnswer: Int(q.correctAnswer)))
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
    
    private func createQuestion(question: Question, context: NSManagedObjectContext)->QuestionCD{
        let questionCd = QuestionCD(context: context)
        questionCd.idCD = Int32(Int(question.id))
        questionCd.correctAnswer = Int32(question.correctAnswer)
        questionCd.question = question.question
        questionCd.answers = question.answers
        return questionCd
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
        for question in quiz.questions {
            cdQuiz.addToQuestions(createQuestion(question: question, context: managedContext))
        }
        try? managedContext.save()
    }
    
    private func updateQuestion(question: Question,  context:NSManagedObjectContext) -> QuestionCD {
        let request: NSFetchRequest<QuestionCD> = QuestionCD.fetchRequest()
        let predicate = NSPredicate(format: "idCD=%@", "\(question.id)")
        request.predicate = predicate
        do {
            let fetchedQuestions: [QuestionCD] = try context.fetch(request)
            if fetchedQuestions.count == 0 {
                return createQuestion(question: question, context: context)
            } else {
                let questionCd = fetchedQuestions[0]
                questionCd.idCD = Int32(Int(question.id))
                questionCd.correctAnswer = Int32(Int(question.correctAnswer))
                questionCd.question = question.question
                questionCd.answers = question.answers
                return questionCd
            }
        } catch (let error) {
            fatalError("Fatal error: \(error.localizedDescription)")
        }
    }
    
    private func updateQuiz(quizCd: QuizCD, quiz: Quiz) {
        let managedContext = coreDataStack.persistentContainer.viewContext
        quizCd.idCD = Int32(quiz.id)
        quizCd.category = quiz.category.rawValue
        quizCd.imageUrl = quiz.imageUrl
        quizCd.level = Int32(quiz.level)
        quizCd.descriptionCd = quiz.description
        quizCd.title = quiz.title
        quizCd.questions = NSSet()
        for question in quiz.questions {
            let questionCd = updateQuestion(question: question, context: managedContext)
            quizCd.addToQuestions(questionCd)
        }
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
    
    func filterQuizzes(searchText: String) -> [Quiz] {
        let request: NSFetchRequest<QuizCD> = QuizCD.fetchRequest()
        let managedContext = coreDataStack.persistentContainer.viewContext
        do {
            let predicate: NSPredicate = NSPredicate(format: "title CONTAINS[c] %@", searchText)
            request.predicate = predicate
            let results = try managedContext.fetch(request)
            return convertToQuizzes(quizzes: results)
        } catch let error as NSError {
            print("Error \(error) | Info: \(error.userInfo)")
        }
        return []
    }
    
}
