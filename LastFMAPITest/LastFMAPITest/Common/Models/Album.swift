//
//  Album.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/5/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Foundation

final class Album: Decodable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
