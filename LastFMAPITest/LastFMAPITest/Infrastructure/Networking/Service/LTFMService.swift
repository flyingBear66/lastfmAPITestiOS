//
//  LTFMService.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/5/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Foundation

class LTFMService {
    
    let lastFMAPIClient: AlamofireHTTPClient
    
    init(lastFMAPIClient: AlamofireHTTPClient) {
        self.lastFMAPIClient = lastFMAPIClient
    }
}
