//
//  LessonJSON.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 9/15/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

struct LessonJSON: Codable {
    var name: String
    var type: String
    var numberOfQuestions: Int
    var scaleDegreesToTest: [Int]
    var key: KeyJSON

    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(LessonJSON.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }

    private enum CodingKeys: String, CodingKey {
        case name, type, numberOfQuestions, scaleDegreesToTest, key
    }
}
