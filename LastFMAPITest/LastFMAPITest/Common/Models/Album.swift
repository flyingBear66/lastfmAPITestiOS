//
//  Album.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/5/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Foundation

public struct Album: Decodable {
    public let name: String
    public let image: [Image]
    
    init(name: String, image: [Image]) {
        self.name = name
        self.image = image
    }
}
