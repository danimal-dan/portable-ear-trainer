//
//  PitchResponseAnalyzer.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/16/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import AudioKit

class PitchResponseAnalyzer {
    var tracker: AKFrequencyTracker;
    var noiseFloor : Double = 0.01;
    var trackerHistory : [FrequencyTrackerSnapshot] = [];
    var ticker : UInt64 = 0;
    var timer : Timer? = nil;
    
    struct FrequencyTrackerSnapshot {
        var frequency : Double;
        var amplitude : Double;
        var tick : UInt64;
    }
    
    // config constants
    let MIN_TRACKED_FREQUENCY = 32.7032; // C1
    let MAX_TRACKED_FREQUENCY = 2093.0; // C7
    let MIN_NUMBER_OF_HISTORY_POINTS = 5;
    let MAX_FREQ_STD_DEVIATION_TO_SELECT_NOTE = 15.0;
    let MIN_FREQ_STD_DEVIATION_TO_CLASSIFY_AS_SPORADIC = 100.0;
    let MAX_NOISE_FLOOR = 0.16;
    let MAX_STEADY_AMPLITUDE_STD_DEVIATION = 0.2;
    
    init(_ tracker : AKFrequencyTracker) {
        self.tracker = tracker;
    }
    
    func start() {
        if (self.timer == nil) {
            self.timer = Timer.scheduledTimer(timeInterval: 0.1,
                                              target: self,
                                              selector: #selector(monitorFrequencyTrackerScheduledTask),
                                              userInfo: nil,
                                              repeats: true);
        }
    }
    
    func stop() {
        self.timer?.invalidate();
    }
    
    @objc func monitorFrequencyTrackerScheduledTask() {
        self.takeSnapshotOfFrequencyTracker();
        self.analyzeTrackerHistory();
        self.ticker += 1;
    }
    
    private func takeSnapshotOfFrequencyTracker() {
        let snapshot = FrequencyTrackerSnapshot(
            frequency: tracker.frequency,
            amplitude: tracker.amplitude,
            tick: self.ticker
        );
        if (self.frequencyIsWithinFilters(snapshot)) {
            self.trackerHistory.append(snapshot);
            print("FREQUENCY: " + String(format: "%0.1f", snapshot.frequency));
            print("AMPLITUDE: " + String(format: "%0.1f", snapshot.amplitude));
            print("NOTE NAME: " + NoteName.forFrequency(tracker.frequency))
        }
    }
    
    private func frequencyIsWithinFilters(_ snapshot : FrequencyTrackerSnapshot) -> Bool {
        return snapshot.amplitude > self.noiseFloor
            && snapshot.frequency >= MIN_TRACKED_FREQUENCY
            && snapshot.frequency <= MAX_TRACKED_FREQUENCY;
    }
    
    // TODO: If there is a mix of high and low frequencies, remove all of the low frequencies. Maybe this could happen when the noise floor is raised
    private func analyzeTrackerHistory() {
        let frequencyList = self.trackerHistory.map({ snapshot in
            return snapshot.frequency;
        });
        
        let frequencyStdDev = Stats.standardDeviation(frequencyList);
        
        if (self.trackerHistory.count > MIN_NUMBER_OF_HISTORY_POINTS) {
            if (frequencyStdDev < MAX_FREQ_STD_DEVIATION_TO_SELECT_NOTE) {
                print("note is steady");
                print("---------");
                print("NOTE SELECTED: " + NoteName.forFrequency(Stats.average(frequencyList)))
                print("---------");
                
                // TODO: At this point we need to stop the audio capture and
                // call a delegate to provide the selected note
                self.trackerHistory = [];
                return;
            }
            
            if (frequencyStdDev > MIN_FREQ_STD_DEVIATION_TO_CLASSIFY_AS_SPORADIC) {
                print("frequency is sporadic");
                self.adjustNoiseFloorIfNeeded();
            }
        }
        
        self.purgeAnyInsignificantHistoryPoints();
    }
    
    private func adjustNoiseFloorIfNeeded() {
        let amplitudeList = self.trackerHistory.map({ snapshot in
            return snapshot.amplitude;
        });
        let avgAmplitude = Stats.average(amplitudeList);
        if (avgAmplitude < MAX_NOISE_FLOOR && self.noiseFloor < MAX_NOISE_FLOOR) {
            print("average amplitude is low");
            
            let amplitudeStdDeviation = Stats.standardDeviation(amplitudeList);
            if (amplitudeStdDeviation < MAX_STEADY_AMPLITUDE_STD_DEVIATION) {
                print("amplitude is steady");
                print("raising noise floor")
                self.noiseFloor += 0.02;
                self.trackerHistory = self.trackerHistory.filter() { snapshot in
                    snapshot.amplitude > self.noiseFloor;
                };
            }
        }
    }
    
    private func purgeAnyInsignificantHistoryPoints() {
        if let lastItem = self.trackerHistory.last, (self.ticker - lastItem.tick) > 5 {
            print("resetting history, too much time has passed since last recorded frequency")
            self.trackerHistory = [];
        } else if (self.trackerHistory.count > 10) {
            print("clear front of history");
            self.trackerHistory.removeSubrange(0...MIN_NUMBER_OF_HISTORY_POINTS);
        }
    }
}
