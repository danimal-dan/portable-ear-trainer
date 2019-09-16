//
//  LessonPlanJSON.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 9/15/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

struct LessonPlanJSON: Codable {
    var name: String
    var lessons: [LessonJSON]

    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(LessonPlanJSON.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }

    private enum CodingKeys: String, CodingKey {
        case name, lessons
    }
}
