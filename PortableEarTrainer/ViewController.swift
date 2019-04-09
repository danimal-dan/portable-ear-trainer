//
//  ViewController.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 1/21/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    static let PLAY_RATE = 1.0
    static let MAJOR_SCALE = [0, 2, 4, 5, 7, 9, 11, 12, 14, 16, 17, 19, 21, 23, 24]
    @IBOutlet weak var PlayButton: UIButton!
    var majorScaleQuiz : MajorScaleQuiz = MajorScaleQuiz()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlayButton.isEnabled = true;
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        do {
            print("play button tapped");
            try self.majorScaleQuiz.playSample();
        } catch {
            print("play error");
        }
    }
    
    // TODO: move to test, can I even test audio output
    func executeSample() {
        let instr = AKRhodesPiano()
        let delay = AKDelay(instr)
        delay.time = 1.5 / ViewController.PLAY_RATE
        delay.dryWetMix = 0.3
        delay.feedback = 0.2
        
        let reverb = AKReverb(delay)
        
        let performance = AKPeriodicFunction(frequency: ViewController.PLAY_RATE) {
            var note = ViewController.MAJOR_SCALE.randomElement()
            let octave = [2, 3, 4, 5].randomElement()! * 12
            if random(in: 0...10) < 1.0 { note! += 1 }
            if !ViewController.MAJOR_SCALE.contains(note! % 12) { print("ACCIDENT!") }
            
            let frequency = (note! + octave).midiNoteToFrequency()
            
            if random(in: 0...6) > 1.0 {
                instr.trigger(frequency: frequency)
                instr.trigger(frequency: frequency + 5)
                instr.trigger(frequency: frequency + 10)
            }
        }
        
        AudioKit.output = reverb
        do {
            try AudioKit.start(withPeriodicFunctions: performance)
        } catch {
            print ("could not start audio")
        }
        performance.start()
    }
    
    // TODO: move to test
    func playCMajor() throws {
        let bank = AKOscillatorBank(waveform: AKTable(.sine),
                                    attackDuration: 0.1,
                                    releaseDuration: 0.1)
        
        AudioKit.output = bank
        try AudioKit.start()
        
        let C = MIDINoteNumber.init(ViewController.MAJOR_SCALE[0] + 60);
        let E = MIDINoteNumber.init(ViewController.MAJOR_SCALE[2] + 60);
        let G = MIDINoteNumber.init(ViewController.MAJOR_SCALE[4] + 60);
        
        bank.play(noteNumber: C, velocity: 80);
        bank.play(noteNumber: E, velocity: 80);
        bank.play(noteNumber: G, velocity: 80);
    }
    
    // TODO: move to test
    func play145() throws {
        let bank = AKOscillatorBank(waveform: AKTable(.sine),
                                    attackDuration: 0.1,
                                    releaseDuration: 0.1)
        
        AudioKit.output = bank
        
        let C = 0;
        let F = 3;
        let G = 4;
        
        var count = 0;
        let performance = AKPeriodicFunction(frequency: ViewController.PLAY_RATE) {
            print(count)
            if (count == 0) {
                self.playMajorChord(rootDegree: C, bank: bank)
            } else if ( count == 1) {
                self.stopMajorChord(rootDegree: C, bank: bank)
                self.playMajorChord(rootDegree: F, bank: bank)
            } else if (count == 2) {
                self.stopMajorChord(rootDegree: F, bank: bank)
                self.playMajorChord(rootDegree: G, bank: bank)
            } else if (count == 3) {
                self.stopMajorChord(rootDegree: G, bank: bank)
                self.playMajorChord(rootDegree: C, bank: bank)
            } else if (count == 6) {
                self.stopMajorChord(rootDegree: C, bank: bank)
                count = -1;
            }
            
            count += 1;
        }
        
        try AudioKit.start(withPeriodicFunctions: performance)
        
        performance.start();
    }
    
    func playMajorChord(rootDegree : Int, bank : AKOscillatorBank) {
        bank.play(noteNumber: getMidiNoteNumber(rootDegree: rootDegree), velocity: 80);
        bank.play(noteNumber: getMidiNoteNumber(rootDegree: rootDegree + 2), velocity: 80);
        bank.play(noteNumber: getMidiNoteNumber(rootDegree: rootDegree + 4), velocity: 80);
    }
    
    func stopMajorChord(rootDegree : Int, bank : AKOscillatorBank) {
        bank.stop(noteNumber: getMidiNoteNumber(rootDegree: rootDegree));
        bank.stop(noteNumber: getMidiNoteNumber(rootDegree: rootDegree + 2));
        bank.stop(noteNumber: getMidiNoteNumber(rootDegree: rootDegree + 4));
    }
    
    func getMidiNoteNumber(rootDegree : Int, octave : Int = 5) -> MIDINoteNumber {
        let octaveStart = octave * 12;
        return MIDINoteNumber(ViewController.MAJOR_SCALE[rootDegree] + octaveStart)
    }
}

