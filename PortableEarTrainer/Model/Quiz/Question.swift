//
//  Question.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 8/19/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import AudioKit

class Question {
    var key: Key
    var targetScaleDegree: Int

    init(_ key: Key, _ targetScaleDegree: Int) {
        self.key = key
        self.targetScaleDegree = targetScaleDegree
    }
}
