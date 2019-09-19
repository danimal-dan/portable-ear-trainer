//
//  LessonPlanTemplate.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 9/15/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

struct LessonPlanTemplate: Codable {
    var name: String
    var lessons: [LessonTemplate]

    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(LessonPlanTemplate.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }

    private enum CodingKeys: String, CodingKey {
        case name, lessons
    }
}
