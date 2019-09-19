//
//  ScaleFactory.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 9/18/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

class ScaleFactory {
    static func scaleOf(type: ScaleType) -> Scale {
        switch type {
        case .majorScale:
            return MajorScale()
        case .minorScale:
            return MinorScale()
        }
    }
}
