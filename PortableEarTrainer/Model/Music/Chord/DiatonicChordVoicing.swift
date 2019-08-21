//
//  DiatonicChordVoicing.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 8/18/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

class DiatonicChordVoicing {
    let scale: Scale;
    
    init(_ scale: Scale) {
        self.scale = scale;
    }
    
    func getTriad(_ rootScaleDegree: Int, maxNotesInScale: Int = 4) -> [Int] {
        let scaleIntervals = self.scale.getIntervals();
        let nextOctave = scaleIntervals.map { $0 + 12 };
        
        let twoOctaveScaleIntervals = scaleIntervals + nextOctave;
        
        // degrees for triad
        let one = rootScaleDegree % 7;
        let three = (one + 2) % 7;
        let five = (three + 2) % 7;
        
        let degreesInChord = [one, three, five];
        
        var intervalsInChord: [Int] = [];
        for (index, interval) in twoOctaveScaleIntervals.enumerated() {
            let degree = (index + 1) % 7;
            
            if (degreesInChord.contains(degree)) {
                intervalsInChord.append(interval);
            }
        }
        
        return Array(intervalsInChord.prefix(maxNotesInScale));
    }
}
