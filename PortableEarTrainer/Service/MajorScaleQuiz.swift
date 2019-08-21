//
//  MajorScaleQuiz.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/13/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation



class MajorScaleQuiz {
    private var numberOfQuestions = 20
    private var questions: [MajorScaleQuestion] = []
    private var answerResults: [Bool] = []
    private var currentPosition: Int = -1
    weak var delegate: QuizDelegate?

    init(_ numberOfQuestions: Int = 20) {
        self.numberOfQuestions = numberOfQuestions
        self.generateQuestions()
    }

    func cancel() {
        self.getCurrentQuestion().stopSample()
    }

    private func generateQuestions() {
        var questionList: [MajorScaleQuestion] = []
        for _ in (0...numberOfQuestions) {
            questionList.append(MajorScaleQuestion())
        }

        self.questions = questionList
    }

    public func getCurrentQuestion() -> MajorScaleQuestion {
        return questions[currentPosition]
    }

    public func startQuiz() {
        self.loadNextQuestion()
        delegate?.answerCollectionDidChange(answerCollection: answerResults)
    }

    public func loadNextQuestion() {
        if self.currentPosition > -1 {
            // don't really like this, should handle this another way...
            getCurrentQuestion().stopSample()
        }

        self.currentPosition += 1
        delegate?.currentQuestionDidChange(currentQuestion: self.getCurrentQuestion(), index: self.currentPosition)
    }

    public func playQuestionSample() {
        do {
            print("playing current question")
            try self.getCurrentQuestion().playSample()
        } catch {
            print("play error")
        }
    }

    public func answerQuestion(_ scaleDegree: Int) -> Bool {
        let question: MajorScaleQuestion = self.getCurrentQuestion()
        let isCorrect = question.verifyAnswer(scaleDegree)
        answerResults.append(isCorrect)

        delegate?.answerCollectionDidChange(answerCollection: answerResults)

        return isCorrect
    }

    public func getTotalQuestions() -> Int {
        return self.numberOfQuestions
    }
}
