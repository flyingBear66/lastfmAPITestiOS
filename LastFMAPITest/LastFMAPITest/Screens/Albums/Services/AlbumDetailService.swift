//
//  AlbumDetailService.swift
//  LastFMAPITest
//
//  Created by Ozgun Emre Zor on 07/07/2019.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import UIKit
import RxSwift

class AlbumDetailService: LTFMService {

    func getAlbumDetail(withAlbumName albumName: String, artistName: String) -> Observable<AlbumDetailResponse> {
        return lastFMAPIClient.request(LastFMAPI.getAlbumDetail(withAlbumName: albumName, artistName: artistName)).asObservable()
    }
    
}
