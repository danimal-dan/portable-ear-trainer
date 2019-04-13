//
//  MajorScaleTest.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/9/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import AudioKit

class MajorScaleQuiz {
    let major145Player : Major145Player = Major145Player()
    var key : MIDINoteNumber;
    var targetScaleDegree: Int;
    
    init() {
        key = MIDINoteNumber(random(in: 48...60));
        targetScaleDegree = Int(random(in: 1...8));
    }
    
    func playSample() throws {
        let target = getTargetNoteNumber(keyStart: key)
        print("KEY/TARGET", key, target);
        try major145Player.playSequence(keyStartNote: key, targetNote: target)
    }
    
    func verifyAnswer(_ scaleDegree : Int) -> Bool {
        return scaleDegree == targetScaleDegree;
    }
    
    private func getTargetNoteNumber(keyStart : MIDINoteNumber) -> MIDINoteNumber {
        let scaleOffset = UInt8(MajorScale.getScaleDegree(targetScaleDegree));
        
        return keyStart + scaleOffset;
    }
}
