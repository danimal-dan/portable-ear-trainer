//
//  LessonBuilderTest.swift
//  PortableEarTrainerTests
//
//  Created by Daniel Collins on 9/6/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import XCTest
import AudioKit
@testable import PortableEarTrainer

class LessonBuilderTest: XCTestCase {

    func testSingleKeyBuilder() {
        let key = Key(startingNote: MIDINoteNumber(60), scale: MajorScale())
        let numberOfQuestions = 5
        let scaleDegreesToTest = [1, 2, 3, 4]
        let builder = SingleKeyLessonBuilder("Test", key: key, scaleDegreesToTest: scaleDegreesToTest, numberOfQuestions: numberOfQuestions)

        let quiz = builder.buildLesson()

        assert(quiz.questions.count == numberOfQuestions, "Question count does not match provided amount")
        quiz.questions.forEach({ question in
            let isInAvailableQuestions = scaleDegreesToTest.contains(question.targetScaleDegree)
            assert(isInAvailableQuestions, "'Question.answer' should always be one of the provided scale degrees.")

            let isCorrectStartNote = question.key.startingNote == key.startingNote
            assert(isCorrectStartNote, "'Question.key.startingNote' should match input.")

            let isCorrectScale = question.key.scale.getIntervals().elementsEqual(key.scale.getIntervals())
            assert(isCorrectScale, "'Question.key.scale' should match input.")

        })
    }

}
