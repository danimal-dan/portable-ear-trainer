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
    static let PLAY_RATE = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        executeSample()
    }

    func executeSample() {
        let instr = AKRhodesPiano()
        let delay = AKDelay(instr)
        delay.time = 1.5 / ViewController.PLAY_RATE
        delay.dryWetMix = 0.3
        delay.feedback = 0.2
        
        let reverb = AKReverb(delay)
        
        let scale = [0, 2, 4, 5, 7, 9, 11, 12]
        let performance = AKPeriodicFunction(frequency: ViewController.PLAY_RATE) {
            var note = scale.randomElement()
            let octave = [2, 3, 4, 5].randomElement()! * 12
            if random(in: 0...10) < 1.0 { note! += 1 }
            if !scale.contains(note! % 12) { print("ACCIDENT!") }
            
            let frequency = (note! + octave).midiNoteToFrequency()
            
            if random(in: 0...6) > 1.0 {
                instr.trigger(frequency: frequency)
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
}

