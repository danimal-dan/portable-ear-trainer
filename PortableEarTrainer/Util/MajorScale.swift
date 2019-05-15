//
//  MajorScaleUtil.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/9/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

final class MajorScale {
    static let SCALE = [0, 2, 4, 5, 7, 9, 11, 12]
    static let I: [Int] = [0, 4, 7, 12]
    static let IV: [Int] = [0, 5, 9, 12]
    static let V: [Int] = [2, 7, 11, 14]

    private init() {}

    static func getScaleDegree(_ degree: Int) -> Int {
        assert(degree > 0)
        let octaveOffset: Int = Int(floor(Double(degree) / Double(SCALE.count)) * 12)

        return SCALE[(degree - 1) % (SCALE.count - 1)] + octaveOffset
    }
}
