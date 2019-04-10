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
    
    static func getNoteName(_ midiNoteNumber : MIDINoteNumber, includeOctave : Bool = false) -> String {
        let (remainder, _) = midiNoteNumber.remainderReportingOverflow(dividingBy: 12);
        
        let noteName = NoteName.notes[Int(remainder)];
        if (includeOctave) {
            let (quotient, _) = midiNoteNumber.dividedReportingOverflow(by: 12);
            let octaveNumber = String(Int(quotient) - 1);
            return noteName + octaveNumber;
        }
        
        return noteName;
    }
}
