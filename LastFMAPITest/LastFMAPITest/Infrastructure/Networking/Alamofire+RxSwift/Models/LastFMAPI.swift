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
    
    static func getFlyingBearPublicRepos() -> Endpoint<[Album]> {
        return Endpoint(path: "")
    }

}
