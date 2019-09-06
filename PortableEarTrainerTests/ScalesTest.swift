//
//  ScalesTest.swift
//  PortableEarTrainerTests
//
//  Created by Daniel Collins on 8/17/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import XCTest
@testable import PortableEarTrainer

class ScalesTest: XCTestCase {
    
    func test1ChordDefinition() {
        let majorScale: Scale = MajorScale();
        let voicing = DiatonicChordVoicing(majorScale);
        let oneChordNotes = voicing.getTriad(1);
        print("1 Chord");
        print(oneChordNotes);
        
        let fourChordNotes = voicing.getTriad(4);
        print("4 Chord");
        print(fourChordNotes);
        
        let fiveChordNotes = voicing.getTriad(5);
        print("5 Chord");
        print(fiveChordNotes);
    }
}
