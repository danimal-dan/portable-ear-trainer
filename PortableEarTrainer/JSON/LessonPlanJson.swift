//
//  LessonPlanJSON.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 9/15/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

struct LessonPlanJson: Codable {
    var name: String
    var lessons: [LessonJson]

    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(LessonPlanJson.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }

    private enum CodingKeys: String, CodingKey {
        case name, lessons
    }
}
