//
//  LessonPlanDataAssetLoader.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 9/17/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import UIKit

class LessonPlanDataAssetLoader {
    private static let LESSON_PLAN_ASSET_NAME = "LessonPlans"

    static func load() throws -> LessonPlanDataAsset {
        let asset = try loadAsset()
        let dictionary = try convertAssetToJsonDictionary(asset)

        return try LessonPlanDataAsset(dictionary: dictionary)
    }

    private static func convertAssetToJsonDictionary(_ asset: NSDataAsset) throws -> [String: Any] {
        let jsonObject = try JSONSerialization.jsonObject(with: asset.data, options: [])

        guard let jsonDictionary = jsonObject as? [String: Any] else {
            fatalError("Could not convert '\(LESSON_PLAN_ASSET_NAME)' NSDataAsset to dictionary.")
        }

        return jsonDictionary
    }

    private static func loadAsset() throws -> NSDataAsset {
        guard let asset = NSDataAsset(name: LESSON_PLAN_ASSET_NAME) else {
            fatalError("Could not load NSDataAsset named '\(LESSON_PLAN_ASSET_NAME)'")
        }

        return asset
    }
}
