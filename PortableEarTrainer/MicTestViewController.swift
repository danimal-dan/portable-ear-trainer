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
    var noiseFloor : Double = 0.01;
    var frequencyHistory : [FrequencySnapshot] = [];
    
    struct FrequencySnapshot {
        var frequency : Double;
        var amplitude : Double;
    }

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
        if (tracker.amplitude > self.noiseFloor) {
            let snapshot = FrequencySnapshot(frequency: tracker.frequency, amplitude: tracker.amplitude);
            self.frequencyHistory.append(snapshot);
            self.analyzeHistory();
            // TODO: should require user to maintain note for some number of frames to make sure choice is deliberate.
            print("FREQUENCY: " + String(format: "%0.1f", snapshot.frequency));
            print("AMPLITUDE: " + String(format: "%0.1f", snapshot.amplitude));
            print("NOTE NAME: " + NoteName.forFrequency(tracker.frequency))
        }
    }
    
    func analyzeHistory() {
        if (self.frequencyHistory.count < 10) {
            return;
        }
        
        let frequencyList = self.frequencyHistory.map({ snapshot in
            return snapshot.frequency;
        });
        
        let amplitudeList = self.frequencyHistory.map({ snapshot in
            return snapshot.amplitude;
        });
        
        let frequencyStdDev = Stats.standardDeviation(frequencyList);
        
        if (frequencyStdDev < 15) {
            print("note is steady");
            print("---------");
            print("NOTE SELECTED: " + NoteName.forFrequency(Stats.average(frequencyList)))
            print("---------");
        }
        
        if (frequencyStdDev > 100) {
            print("frequency is sporadic")
            let avgAmplitude = Stats.average(amplitudeList);
            if (avgAmplitude < 0.4) {
                print("average amplitude is low");
                
                let amplitudeStdDeviation = Stats.standardDeviation(amplitudeList);
                if (amplitudeStdDeviation < 0.2) {
                    print("amplitude is steady");
                    print("raising noise floor")
                    self.noiseFloor += 0.02;
                    self.frequencyHistory = [];
                }
            }
        }
        
        if (self.frequencyHistory.count > 20) {
            print("reset history");
            self.frequencyHistory = [];
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
