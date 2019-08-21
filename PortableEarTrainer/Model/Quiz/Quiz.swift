//
//  Quiz.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 8/19/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

protocol QuizDelegate {
    func currentQuestionDidChange(currentQuestion: Question, index: Int)
    
    func answerCollectionDidChange(answerCollection: [Bool])
}

class Quiz {
    var delegate: QuizDelegate?;
    var questions: [Question];
    var answers: [Answer] = [];
    
    init(_ questions: [Question]) {
        self.questions = questions;
    }
}
