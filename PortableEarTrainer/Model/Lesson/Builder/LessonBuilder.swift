//
//  LessonBuilder.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 8/19/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

protocol LessonBuilder {
    var numberOfQuestions: Int { get }

    func buildLesson() -> Lesson

    func buildQuestion() -> Question
}
