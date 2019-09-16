//
//  SingleKeyLessonBuilder.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 8/19/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

class SingleKeyLessonBuilder: LessonBuilder {
    var name: String
    var key: Key
    var scaleDegreesToTest: [Int]
    var numberOfQuestions: Int

    init(_ name: String, key: Key, scaleDegreesToTest: [Int], numberOfQuestions: Int = 20) {
        self.name = name
        self.key = key
        self.scaleDegreesToTest = scaleDegreesToTest
        self.numberOfQuestions = numberOfQuestions
    }

    func buildLesson() -> Lesson {
        var questions: [Question] = []
        for _ in 0..<numberOfQuestions {
            questions.append(self.buildQuestion())
        }

        return Lesson(name, questions: questions)
    }

    func buildQuestion() -> Question {
        let scaleDegree = getRandomScaleDegree()

        return Question(key, scaleDegree)
    }

    private func getRandomScaleDegree() -> Int {
        return scaleDegreesToTest.randomElement()!
    }
}
