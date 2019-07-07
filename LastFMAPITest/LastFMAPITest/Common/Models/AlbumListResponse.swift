//
//  AlbumListResponse.swift
//  LastFMAPITest
//
//  Created by Ozgun Emre Zor on 06/07/2019.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Foundation

public struct AlbumListResponse: Decodable {
    public let albums: AlbumsResponse
}

