//
//  Stats.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 4/15/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

final class Stats {
    private init() {}
    
    static func average(_ list : [Double]) -> Double {
        let length = Double(list.count);
        return list.reduce(0) { sum, val in
            return (val / length) + sum;
        };
    }
    
    static func standardDeviation(_ list : [Double]) -> Double {
        let length = Double(list.count);
        let avg = list.reduce(0, +) / length;
        let sumOfSquaredAvgDiff = list.map { pow($0 - avg, 2.0)}.reduce(0, {$0 + $1});
        return sqrt(sumOfSquaredAvgDiff / length);
    }
}
