//
//  NoteNameUtilTest.swift
//  PortableEarTrainerTests
//
//  Created by Daniel Collins on 4/9/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import XCTest
import AudioKit
@testable import PortableEarTrainer

class NoteNameUtilTest: XCTestCase {

    func testNoteName() {
        let shouldBeA = NoteName.forMIDINoteNumber(MIDINoteNumber(21))
        let shouldBeC = NoteName.forMIDINoteNumber(MIDINoteNumber(60))

        XCTAssertEqual(shouldBeA, "A")
        XCTAssertEqual(shouldBeC, "C")
    }

    func testNoteNameWithOctave() {
        let shouldBeA = NoteName.forMIDINoteNumber(MIDINoteNumber(21), includeOctave: true)
        let shouldBeC = NoteName.forMIDINoteNumber(MIDINoteNumber(60), includeOctave: true)

        XCTAssertEqual(shouldBeA, "A0")
        XCTAssertEqual(shouldBeC, "C4")
    }
}
