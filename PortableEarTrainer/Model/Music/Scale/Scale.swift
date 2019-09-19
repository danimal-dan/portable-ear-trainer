//
//  Scale.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 8/17/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

protocol Scale {
    static var intervals: [Int] { get }

    func getIntervals() -> [Int]

    func getIntervalFor(scaleDegree: Int) -> Int
}

extension Scale {
    func getIntervals() -> [Int] {
        return Self.intervals
    }

    /**
        Returns the interval from the scale root for the given scale degree.
        e.g. Major Scale: getIntervalFor(scaleDegree: 3) => 4
    */
    func getIntervalFor(scaleDegree: Int) -> Int {
        assert(scaleDegree > 0)
        let noteCount = Self.intervals.count

        let octaveOffset: Int = Int(floor(Double(scaleDegree) / Double(noteCount + 1)) * 12)

        return Self.intervals[(scaleDegree - 1) % noteCount] + octaveOffset
    }
}
