//
//  StatsTest.swift
//  PortableEarTrainerTests
//
//  Created by Daniel Collins on 4/15/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import XCTest
@testable import PortableEarTrainer

class StatsTest: XCTestCase {

    func testAverage() {
        let list = [1.0, 2.0, 3.0]
        let avg = Stats.average(list)
        XCTAssertEqual(avg, 2.0)
    }

    func testStandardDeviation() {
        let list = [1.0, 2.0, 3.0]
        let stdDeviation = Stats.standardDeviation(list)
        XCTAssertLessThan(fabs(stdDeviation - 0.8164965809), 0.000001)
    }
}
