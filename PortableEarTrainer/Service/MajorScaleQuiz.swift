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
    
    func playSample() throws {
        let key = pickRandomKey();
        let target = pickRandomScaleDegree(keyStart: key)
        print("KEY/TARGET", key, target);
        try major145Player.playSequence(keyStartNote: key, targetNote: target)
    }
    
    private func pickRandomKey() -> MIDINoteNumber {
        return MIDINoteNumber(random(in: 60...72));
    }
    
    private func pickRandomScaleDegree(keyStart : MIDINoteNumber) -> MIDINoteNumber {
        let scaleDegree = Int(random(in: 1...7));
        let scaleOffset = UInt8(MajorScale.getScaleDegree(scaleDegree));
        
        return keyStart + scaleOffset;
    }
}
