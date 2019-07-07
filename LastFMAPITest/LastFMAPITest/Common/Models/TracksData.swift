//
//  TracksData.swift
//  LastFMAPITest
//
//  Created by Ozgun Emre Zor on 07/07/2019.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Foundation

public struct TracksData: Decodable {
    public let track: [Track]
}
