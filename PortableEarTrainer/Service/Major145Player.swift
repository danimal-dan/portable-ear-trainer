//
//  Major145Player.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/8/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import AudioKit

class Major145Player {
    private var bank : AKOscillatorBank;
    private var performance : AKPeriodicFunction?;
    private var iteration : Int = 0;
    private var startNote : MIDINoteNumber = MIDINoteNumber(60);
    private var targetNote : MIDINoteNumber = MIDINoteNumber(60);
    
    init() {
        bank = AKOscillatorBank(waveform: AKTable(.triangle),
                                attackDuration: 0.001,
                                decayDuration: 0.3,
                                sustainLevel: 0.1,
                                releaseDuration: 0.2);
    }
    
    func playSequence(keyStartNote : MIDINoteNumber, targetNote : MIDINoteNumber) throws {
        guard self.performance == nil || self.performance?.isPlaying == false else {
            print("performance is already playing")
            return;
        }
        self.startNote = keyStartNote;
        self.targetNote = targetNote;
        initPerformance();
        
        if let performance = self.performance {
            AudioKit.output = self.bank;
            try AudioKit.start(withPeriodicFunctions: performance);
            performance.start();
        }
    }
    
    func stopSequence() throws {
        if let performance = self.performance {
            performance.stop();
            try AudioKit.stop();
        }
        self.iteration = 0;
    }
    
    private func initPerformance() {
        self.performance = AKPeriodicFunction(frequency: 1.0) {
            print("Performation iteration: ", self.iteration);
            if (self.iteration == 0) {
                self.playChord(MajorScale.I)
            } else if (self.iteration == 1) {
                self.stopChord(MajorScale.I)
                self.playChord(MajorScale.IV)
            } else if (self.iteration == 2) {
                self.stopChord(MajorScale.IV)
                self.playChord(MajorScale.V)
            } else if (self.iteration == 3) {
                self.stopChord(MajorScale.V)
                self.playChord(MajorScale.I)
            } else if (self.iteration == 5) {
                self.stopChord(MajorScale.I)
            } else if (self.iteration == 6) {
                self.bank.play(noteNumber: self.targetNote, velocity: 80)
            } else if ( self.iteration == 8) {
                self.bank.stop(noteNumber: self.targetNote)
            }
            
            self.iteration += 1;
            
            if (self.iteration > 8) {
                do {
                    try self.stopSequence();
                } catch {
                    print("could not stop sequence, uh oh");
                }
            }
        }
    }
    
    private func playChord(_ chordTones : [Int]) {
        for tone in chordTones {
            bank.play(noteNumber: self.startNote + UInt8(tone), velocity: 80);
        }
    }
    
    private func stopChord(_ chordTones : [Int]) {
        for tone in chordTones {
            bank.stop(noteNumber: self.startNote + UInt8(tone));
        }
    }
}
