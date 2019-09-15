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

    func getScaleDegree(_ degree: Int) -> Int
}

extension Scale {
    func getIntervals() -> [Int] {
        return Self.intervals
    }

    /**
        Returns the interval from the scale root for the given scale degree.
        e.g. C maj: getScaleDegree(3) => 4
    */
    func getScaleDegree(_ degree: Int) -> Int {
        assert(degree > 0)
        let noteCount = Self.intervals.count

        let octaveOffset: Int = Int(floor(Double(degree) / Double(noteCount)) * 12)

        return Self.intervals[(degree - 1) % (noteCount - 1)] + octaveOffset
    }
}
