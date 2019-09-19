//
//  DataAssetInfo.swift
//  PortableEarTrainer
//
//  Created by Daniel Collins on 9/15/19.
//  Copyright © 2019 Daniel Collins. All rights reserved.
//

import Foundation

struct DataAssetInfo: Codable {
    var version: Int
    var author: String

    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(DataAssetInfo.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }

    private enum CodingKeys: String, CodingKey {
        case version, author
    }
}
