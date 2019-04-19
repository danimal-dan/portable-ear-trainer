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
    var pitchResponseAnalyzer : PitchResponseAnalyzer!;

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
        rollingPlot.gain = 1
        addView(rollingPlot)
        
        self.pitchResponseAnalyzer = PitchResponseAnalyzer(tracker);
        self.pitchResponseAnalyzer.start();
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
