//
//  LessonPlanDataAssetTests.swift
//  PortableEarTrainerTests
//
//  Created by Daniel Collins on 9/15/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import XCTest
@testable import PortableEarTrainer

class LessonPlanDataAssetTests: XCTestCase {

    func testCanLoadLessonPlansDataAsset() {
        if let asset = NSDataAsset(name: "LessonPlans") {
            let data = asset.data
            let d = try? JSONSerialization.jsonObject(with: data, options: [])

            assert(d != nil)
        }
    }

    func testCanDecodeLessonPlansDataAsset() {
        if let asset = NSDataAsset(name: "LessonPlans") {
            let data = asset.data
            let d = try? JSONSerialization.jsonObject(with: data, options: [])

            assert(d != nil)

            var dataAsset: LessonPlanDataAssetJSON?
            if let dictionary = d as? [String: Any] {
                dataAsset = try? LessonPlanDataAssetJSON(dictionary: dictionary)
            }

            assert(dataAsset != nil)
        }
    }

}
