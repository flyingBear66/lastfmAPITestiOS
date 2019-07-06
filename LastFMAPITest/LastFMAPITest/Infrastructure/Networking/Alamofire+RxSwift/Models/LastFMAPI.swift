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
    
//    static func getTop100HiphopAlbums(limit: Int, offset: Int) -> Endpoint<[Album]> {
    static func getTop100HiphopAlbums() -> Endpoint<APIResponse> {
//        return Endpoint(path: "", parameters: ["limit": limit, "offset": offset])
        return Endpoint(path: "tag.gettopalbums&tag=hiphop")
    }

}
