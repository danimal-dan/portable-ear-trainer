//
//  KeyJSON.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 9/15/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

struct KeyJSON: Codable {
    var scale: String
    var startNote: Int

    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(KeyJSON.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }

    private enum CodingKeys: String, CodingKey {
        case scale, startNote
    }
}
