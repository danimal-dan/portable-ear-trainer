//
//  LessonPlanDataAssetJSON.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 9/15/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

struct LessonPlanDataAssetJson: Codable {
    var info: DataAssetInfoJson
    var data: [LessonPlanJson]

    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(LessonPlanDataAssetJson.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }

    private enum CodingKeys: String, CodingKey {
        case info, data
    }
}
