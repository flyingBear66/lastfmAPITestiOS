//
//  AlbumListService.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/5/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import UIKit
import RxSwift

class AlbumListService: LTFMService {

    var page = 0
    let albumPerPage = 20

    func getAlbums() -> Observable<AlbumListResponse> {
        page+=1
        return lastFMAPIClient.request(LastFMAPI.getTop100HiphopAlbums(page: page, albumPerPage: albumPerPage)).asObservable()
    }



}
