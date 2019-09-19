//
//  LessonTemplate.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 9/15/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

struct LessonTemplate: Codable {
    var name: String
    var lessonType: LessonType
    var numberOfQuestions: Int
    var scaleDegreesToTest: [Int]
    var key: KeyTemplate

    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(LessonTemplate.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }

    private enum CodingKeys: String, CodingKey {
        case name, lessonType, numberOfQuestions, scaleDegreesToTest, key
    }
}
