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
    
    static let I : [Int] = [0, 4, 7, 12];
    static let IV : [Int] = [0, 5, 9, 12];
    static let V : [Int] = [2, 7, 11, 14];
    
    init() {
        bank = AKOscillatorBank(waveform: AKTable(.sine),
                                attackDuration: 0.1,
                                releaseDuration: 0.1);
    }
    
    func playSequence(startNote : MIDINoteNumber) throws {
        self.startNote = startNote;
        
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
        self.performance = AKPeriodicFunction(frequency: ViewController.PLAY_RATE) {
            print("Performation iteration: ", self.iteration);
            if (self.iteration == 0) {
                self.playChord(Major145Player.I)
            } else if (self.iteration == 1) {
                self.stopChord(Major145Player.I)
                self.playChord(Major145Player.IV)
            } else if (self.iteration == 2) {
                self.stopChord(Major145Player.IV)
                self.playChord(Major145Player.V)
            } else if (self.iteration == 3) {
                self.stopChord(Major145Player.V)
                self.playChord(Major145Player.I)
            } else if (self.iteration == 5) {
                self.stopChord(Major145Player.I)
            }
            
            self.iteration += 1;
            
            if (self.iteration > 5) {
                self.iteration = 0;
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
