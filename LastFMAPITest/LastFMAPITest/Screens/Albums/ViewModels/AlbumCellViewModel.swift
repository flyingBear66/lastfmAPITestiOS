//
//  AlbumCellViewModel.swift
//  LastFMAPITest
//
//  Created by Ozgun Emre Zor on 05/07/2019.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import UIKit

class AlbumCellViewModel: LTFMViewModel {

    // MARK: - Variables
    private let album: Album
//    public let albumImageURLString: String
//    public let albumName: String
//    public var albumId: Int {
//        get {
//            return self.album.id
//        }
//    }

    // MARK: - Init
    init(album: Album) {
        self.album = album
//        self.albumName = album.name ?? "N/a"
//        if let thumbnail = hero.thumbnail {
//            self.heroImageURLString = thumbnail.url.absoluteString
//        } else {
//            self.heroImageURLString = ""
//        }
    }

    // MARK: - Public Methods

}
