//
//  AlbumDetail.swift
//  LastFMAPITest
//
//  Created by Ozgun Emre Zor on 07/07/2019.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Foundation

public struct AlbumDetail: Decodable {
    public let name: String
    public let artist: String
    public let image: [Image]
    public let listeners: String
    public let tracks: TracksData
    public let wiki: WikiData?
}
