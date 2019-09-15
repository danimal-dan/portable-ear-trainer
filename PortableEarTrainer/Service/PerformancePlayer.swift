//
//  BasePerformancePlayer.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 8/21/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation
import AudioKit

protocol PerformancePlayer {
    var bank: AKOscillatorBank { get set }
    var performance: AKPeriodicFunction? { get set}

    func play() throws

    func stop()
}
