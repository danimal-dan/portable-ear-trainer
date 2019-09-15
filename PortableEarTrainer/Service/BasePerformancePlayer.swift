//
//  BasePerformancePlayer.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 8/21/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import AudioKit

class BasePerformancePlayer: PerformancePlayer {
    var bank: AKOscillatorBank

    var performance: AKPeriodicFunction?

    init() {
        bank = AKOscillatorBank(waveform: AKTable(.triangle),
                                attackDuration: 0.001,
                                decayDuration: 0.3,
                                sustainLevel: 0.1,
                                releaseDuration: 0.2)
    }

    func play() throws {
        if let performance = self.performance {
            AudioKit.output = self.bank
            try AudioKit.start(withPeriodicFunctions: performance)
            performance.start()
        }
    }

    func stop() {
        if let performance = self.performance {
            performance.stop()
            do {
                try AudioKit.stop()
            } catch {
                print("Could not stop audiokit")
            }
        }
    }

    deinit {
        self.stop()
        self.performance?.detach()
        self.bank.detach()
    }
}
