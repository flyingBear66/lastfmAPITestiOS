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

    var offset = 0
    let limit = 20

//    func getAlbums() -> Observable<[Album]> {APIResponse
    func getAlbums() -> Observable<APIResponse> {
//        return lastFMAPIClient.request(LastFMAPI.getTop100HiphopAlbums(limit: limit, offset: offset)).asObservable()
        return lastFMAPIClient.request(LastFMAPI.getTop100HiphopAlbums()).asObservable()
    }



}
