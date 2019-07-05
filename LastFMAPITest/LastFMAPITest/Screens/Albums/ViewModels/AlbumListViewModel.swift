//
//  AlbumListViewModel.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/5/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import UIKit

class AlbumListViewModel: LTFMViewModel {

    // MARK: - Variables    
    internal var service: AlbumListService
    
    // MARK: - Init
    init(service: AlbumListService) {
        self.service = service
    }
    
}
