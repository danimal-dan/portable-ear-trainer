//
//  CadenceWithTargetPerformance.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 8/21/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import AudioKit

class CadenceWithTargetPerformance: BasePerformancePlayer {
    private var startNote: MIDINoteNumber = MIDINoteNumber(60)
    private var targetNote: MIDINoteNumber = MIDINoteNumber(60)
    private var chordVoicing: DiatonicChordVoicing

    init(_ scale: Scale) {
        self.chordVoicing = DiatonicChordVoicing(scale)
    }

    func playSequence(keyStartNote: MIDINoteNumber, targetNote: MIDINoteNumber) throws {
        guard self.performance == nil || self.performance?.isPlaying == false else {
            print("performance is already playing")
            return
        }
        self.startNote = keyStartNote
        self.targetNote = targetNote
        initPerformance()

        try self.play()
    }

    private func initPerformance() {
        let oneChord = chordVoicing.getTriad(1)
        let fourChord = chordVoicing.getTriad(4)
        let fiveChord = chordVoicing.getTriad(5)

        var iteration = 0
        self.performance = AKPeriodicFunction(frequency: 1.5) {
            print("Performation iteration: ", iteration)
            if iteration == 0 {
                self.playChord(oneChord)
            } else if iteration == 1 {
                self.stopChord(oneChord)
                self.playChord(fourChord)
            } else if iteration == 2 {
                self.stopChord(fourChord)
                self.playChord(fiveChord)
            } else if iteration == 3 {
                self.stopChord(fiveChord)
                self.playChord(oneChord)
            } else if iteration == 5 {
                self.stopChord(oneChord)
            } else if iteration == 6 {
                self.bank.play(noteNumber: self.targetNote, velocity: 80)
            } else if iteration == 8 {
                self.bank.stop(noteNumber: self.targetNote)
            }

            iteration += 1

            if iteration > 8 {
                self.stop()
            }
        }
    }

    private func playChord(_ chordTones: [Int]) {
        for tone in chordTones {
            bank.play(noteNumber: self.startNote + UInt8(tone), velocity: 80)
        }
    }

    private func stopChord(_ chordTones: [Int]) {
        for tone in chordTones {
            bank.stop(noteNumber: self.startNote + UInt8(tone))
        }
    }
}
