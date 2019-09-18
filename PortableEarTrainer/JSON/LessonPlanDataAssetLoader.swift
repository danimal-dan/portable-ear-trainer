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

    static func loadLessonPlanJson() throws -> LessonPlanDataAssetJson {
        let asset = try loadAsset()
        let dictionary = try convertAssetToJsonDictionary(asset)

        return try LessonPlanDataAssetJson(dictionary: dictionary)
    }

    private static func convertAssetToJsonDictionary(_ asset: NSDataAsset) throws -> [String: Any] {
        let jsonDictionary = try JSONSerialization.jsonObject(with: asset.data, options: [])

        return jsonDictionary as! [String: Any]
    }

    private static func loadAsset() throws -> NSDataAsset {
        guard let asset = NSDataAsset(name: LESSON_PLAN_ASSET_NAME) else {
            fatalError("Could not load NSDataAsset named '\(LESSON_PLAN_ASSET_NAME)'")
        }

        return asset
    }
}
