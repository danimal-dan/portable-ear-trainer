//
//  LessonJSON.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 9/15/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

struct LessonJson: Codable {
    var name: String
    var type: String
    var numberOfQuestions: Int
    var scaleDegreesToTest: [Int]
    var key: KeyJson

    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(LessonJson.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }

    private enum CodingKeys: String, CodingKey {
        case name, type, numberOfQuestions, scaleDegreesToTest, key
    }
}
