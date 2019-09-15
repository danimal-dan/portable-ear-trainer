//
//  QuizBuilderTest.swift
//  PortableEarTrainerTests
//
//  Created by Daniel Collins on 9/6/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import XCTest
import AudioKit
@testable import PortableEarTrainer

class QuizBuilderTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testSingleKeyBuilder() {
        let key = Key(startingNote: MIDINoteNumber(60), scale: MajorScale())
        let numberOfQuestions = 5
        let scaleDegreesToTest = [1, 2, 3, 4]
        let builder = SingleKeyQuizBuilder(key, scaleDegreesToTest: scaleDegreesToTest, numberOfQuestions: numberOfQuestions)

        let quiz = builder.buildQuiz()

        assert(quiz.questions.count == numberOfQuestions, "Question count does not match provided amount")
        quiz.questions.forEach({
            question in
            let isInAvailableQuestions = scaleDegreesToTest.contains(question.targetScaleDegree)
            assert(isInAvailableQuestions, "'Question.answer' should always be one of the provided scale degrees.")

            let isCorrectStartNote = question.key.startingNote == key.startingNote
            assert(isCorrectStartNote, "'Question.key.startingNote' should match input.")

            let isCorrectScale = question.key.scale.getIntervals().elementsEqual(key.scale.getIntervals())
            assert(isCorrectScale, "'Question.key.scale' should match input.")

        })
    }

}
