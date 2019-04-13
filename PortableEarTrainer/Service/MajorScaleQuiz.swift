//
//  MajorScaleQuiz.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/13/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

protocol QuizDelegate : AnyObject {
    func currentQuestionDidChange(currentQuestion : MajorScaleQuestion, index : Int);
    
    func answerCollectionDidChange(answerCollection : [Bool]);
}

class MajorScaleQuiz {
    private var numberOfQuestions = 20;
    private var questions : [MajorScaleQuestion] = [];
    private var answerResults : [Bool] = [];
    private var currentPosition : Int = 0;
    weak var delegate : QuizDelegate?
    
    init(_ numberOfQuestions : Int = 20) {
        self.numberOfQuestions = numberOfQuestions;
        self.generateQuestions();
    }
    
    private func generateQuestions() {
        var questionList : [MajorScaleQuestion] = [];
        for _ in (0...numberOfQuestions) {
            questionList.append(MajorScaleQuestion())
        }
        
        self.questions = questionList;
    }
    
    public func getCurrentQuestion() -> MajorScaleQuestion {
        return questions[currentPosition];
    }
    
    public func getNextQuestion() -> MajorScaleQuestion {
        self.currentPosition += 1;
        delegate?.currentQuestionDidChange(currentQuestion: self.getCurrentQuestion(), index: self.currentPosition);
        return self.getCurrentQuestion();
    }
    
    public func playQuestionSample() {
        do {
            print("playing current question");
            try self.getCurrentQuestion().playSample();
        } catch {
            print("play error");
        }
    }
    
    public func answerQuestion(_ scaleDegree : Int) -> Bool {
        let question : MajorScaleQuestion = self.getCurrentQuestion();
        let isCorrect = question.verifyAnswer(scaleDegree);
        answerResults.append(isCorrect);
        
        delegate?.answerCollectionDidChange(answerCollection: answerResults);
        
        _ = self.getNextQuestion();
        
        return isCorrect;
    }
    
    public func getTotalQuestions() -> Int {
        return self.numberOfQuestions;
    }
}
