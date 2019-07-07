//
//  LastFMAPI.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/5/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Foundation

enum LastFMAPI {}

extension LastFMAPI {
    
    static func getTop100HiphopAlbums(page: Int, albumPerPage: Int) -> Endpoint<AlbumListResponse> {
        return Endpoint(path: "tag.gettopalbums&tag=hiphop&page=\(page)&limit=\(albumPerPage)")
    }

    static func getAlbumDetail(withAlbumName albumName: String, artistName: String) -> Endpoint<AlbumDetailResponse> {
        return Endpoint(path: "album.getinfo&artist=\(artistName)&album=\(albumName)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
    }
}
