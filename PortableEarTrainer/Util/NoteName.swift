//
//  NoteName.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/9/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import AudioKit

final class NoteName {
    private static let notes : [String] = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"];
    private static let FREQUENCY_OF_C = 261.626;
    
    static func forMIDINoteNumber(_ midiNoteNumber : MIDINoteNumber, includeOctave : Bool = false) -> String {
        let (remainder, _) = midiNoteNumber.remainderReportingOverflow(dividingBy: 12);
        
        let noteName = NoteName.notes[Int(remainder)];
        if (includeOctave) {
            let (quotient, _) = midiNoteNumber.dividedReportingOverflow(by: 12);
            let octaveNumber = String(Int(quotient) - 1);
            return noteName + octaveNumber;
        }
        
        return noteName;
    }
    
    static func forFrequency(_ frequency : Double) -> String {
        let halfSteps = 12 * log(frequency / FREQUENCY_OF_C) / log(2.0);
        let roundedHalfSteps = Int(halfSteps.rounded());
        
        if (halfSteps >= 0) {
            return notes[Int(roundedHalfSteps % notes.count)]
        }
        
        // ex) roundedHalfSteps = -1; so then 12 + (-1 % 12) = 12 + (-1) = 11 which is a B or one half step below C
        return notes[notes.count + Int(roundedHalfSteps % notes.count)]
    }
}
