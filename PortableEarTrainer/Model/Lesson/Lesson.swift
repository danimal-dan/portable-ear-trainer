//
//  Lesson.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 8/19/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

protocol LessonDelegate: class {
    func currentQuestionDidChange(currentQuestion: Question, index: Int)

    func answerCollectionDidChange(answerCollection: [Bool])
}

class Lesson {
    weak var delegate: LessonDelegate?
    var name: String
    var questions: [Question]
    var answers: [Answer] = []

    init(_ name: String, questions: [Question]) {
        self.name = name
        self.questions = questions
    }
}
