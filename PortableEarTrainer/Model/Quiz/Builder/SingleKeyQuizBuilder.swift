//
//  SingleKeyQuizBuilder.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 8/19/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

class SingleKeyQuizBuilder: QuizBuilder {
    var key: Key
    var scaleDegreesToTest: [Int]
    var numberOfQuestions: Int

    init(_ key: Key, scaleDegreesToTest: [Int], numberOfQuestions: Int = 20) {
        self.key = key
        self.scaleDegreesToTest = scaleDegreesToTest
        self.numberOfQuestions = numberOfQuestions
    }

    func buildQuiz() -> Quiz {

        var questions: [Question] = []
        for _ in 0..<numberOfQuestions {
            questions.append(self.buildQuestion())
        }

        return Quiz(questions)
    }

    func buildQuestion() -> Question {
        let scaleDegree = getRandomScaleDegree()

        return Question(key, scaleDegree)
    }

    private func getRandomScaleDegree() -> Int {
        return scaleDegreesToTest.randomElement()!
    }
}
