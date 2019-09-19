//
//  ScalesTest.swift
//  PortableEarTrainerTests
//
//  Created by Daniel Collins on 8/17/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import XCTest
@testable import PortableEarTrainer

class ScalesTest: XCTestCase {

    func testIntervalFromDegree() {
        let majorScale: Scale = MajorScale()

        let scaleDegreeToIntervalRelations = [
            (1, 0),
            (2, 2),
            (3, 4),
            (4, 5),
            (5, 7),
            (6, 9),
            (7, 11),
            (8, 12),
            (9, 14),
            (11, 17),
            (13, 21)
        ]

        for scaleDegreeToInterval in scaleDegreeToIntervalRelations {
            let scaleDegree = scaleDegreeToInterval.0
            let expectedInterval = scaleDegreeToInterval.1
            let actualInterval = majorScale.getIntervalFor(scaleDegree: scaleDegree)

            print("Major Scale Degree \(scaleDegree). Expected: \(expectedInterval) Actual: \(actualInterval)")
            assert(actualInterval == expectedInterval)
        }
    }

    func test1ChordDefinition() {
        let majorScale: Scale = MajorScale()
        let voicing = DiatonicChordVoicing(majorScale)
        let oneChordNotes = voicing.getTriad(1)
        print("1 Chord")
        print(oneChordNotes)

        let fourChordNotes = voicing.getTriad(4)
        print("4 Chord")
        print(fourChordNotes)

        let fiveChordNotes = voicing.getTriad(5)
        print("5 Chord")
        print(fiveChordNotes)
    }
}
