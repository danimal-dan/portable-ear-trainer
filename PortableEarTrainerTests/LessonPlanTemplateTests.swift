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

class LessonPlanTemplateTests: XCTestCase {

    func testCanDecodeLessonPlansDataAsset() {
        let dataAsset = try? LessonPlanDataAssetLoader.load()
        XCTAssertNotNil(dataAsset)
    }

}
