//
//  MajorScaleTest.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/9/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import AudioKit

class MajorScaleQuestion: Question {
    let major145Player: Major145Player = Major145Player()
    var scale: MajorScale = MajorScale()

    init() {
        let key = Key(startingNote: MIDINoteNumber(random(in: 48...60)), scale: MajorScale())
        let targetScaleDegree = Int(random(in: 1...8))

        super.init(key, targetScaleDegree)
    }

    func playSample() throws {
        let target = getTargetNoteNumber(keyStart: key.startingNote)
        print("KEY/TARGET", key.startingNote, target)
        try self.major145Player.playSequence(keyStartNote: key.startingNote, targetNote: target)
    }

    func stopSample() {
        self.major145Player.stopSequence()
    }

    func verifyAnswer(_ scaleDegree: Int) -> Bool {
        return scaleDegree == targetScaleDegree
    }

    private func getTargetNoteNumber(keyStart: MIDINoteNumber) -> MIDINoteNumber {
        let scaleOffset = UInt8(scale.getScaleDegree(targetScaleDegree))

        return keyStart + scaleOffset
    }
}
