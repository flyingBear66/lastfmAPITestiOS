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
    public let albumImageURL: URL?
    public let albumName: String

    // MARK: - Init
    init(album: Album) {
        self.album = album
        self.albumName = album.name
        self.albumImageURL = URL(string:album.image[AlbumCellViewConstants.imageElement].imageURLString)
    }

    // MARK: - Public Methods

}
