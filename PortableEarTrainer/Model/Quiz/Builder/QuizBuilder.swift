//
//  QuizBuilder.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 8/19/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

protocol QuizBuilder {
    var numberOfQuestions: Int { get }

    func buildQuiz() -> Quiz

    func buildQuestion() -> Question
}
