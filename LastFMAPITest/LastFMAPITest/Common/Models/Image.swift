//
//  Image.swift
//  LastFMAPITest
//
//  Created by Ozgun Emre Zor on 06/07/2019.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Foundation

public struct Image: Decodable {
    public let imageURLString: String
    public let size: String


    enum ImageKeys: String, CodingKey { // declaring our keys
        case imageURLString = "#text"
        case size = "size"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        
        let imageURLString: String = try container.decode(String.self, forKey: .imageURLString)
        let size: String = try container.decode(String.self, forKey: .size)

        self.imageURLString = imageURLString
        self.size = size
    }


}
