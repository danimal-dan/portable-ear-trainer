//
//  MicTestViewController.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/13/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class MicTestViewController: AKLiveViewController {
    var mic: AKMicrophone!;
    var tracker: AKFrequencyTracker!;
    var silence: AKBooster!;

    override func viewDidLoad() {
        super.viewDidLoad()
        AKSettings.audioInputEnabled = true
        mic = AKMicrophone()
        tracker = AKFrequencyTracker(mic)
        silence = AKBooster(tracker, gain: 0)
        
        AudioKit.output = silence
        do {
            try AudioKit.start()
        } catch {
            AKLog("AudioKit did not start!")
        }
        
        let rollingPlot = AKNodeOutputPlot(mic, frame: CGRect(x: 0, y: 0, width: 440, height: 200))
        rollingPlot.plotType = .buffer
        rollingPlot.shouldFill = true
        rollingPlot.shouldMirror = true
        rollingPlot.color = AKColor.lightGray
        rollingPlot.gain = 2
        addView(rollingPlot)
        
        Timer.scheduledTimer(timeInterval: 0.1,
                             target: self,
                             selector: #selector(updateUI),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc func updateUI() {
        if (tracker.amplitude > 0.1) {
            // TODO: should require user to maintain note for some number of frames to make sure choice is deliberate.
            print("FREQUENCY: " + String(format: "%0.1f", tracker.frequency));
            print("NOTE NAME: " + NoteName.forFrequency(tracker.frequency))
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
