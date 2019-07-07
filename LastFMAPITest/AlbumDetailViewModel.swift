//
//  AlbumDetailViewModel.swift
//  
//
//  Created by Ozgun Emre Zor on 07/07/2019.
//

import UIKit
import RxSwift

class AlbumDetailViewModel: LTFMViewModel {

    // MARK: - Variables
    public var album: Album = Album()

    public let albumName: Variable<String> = Variable("Init")
    public let albumImageURL: Variable<String> = Variable("Init")
    public let publishDate: Variable<String> = Variable("Init")
    public let tracksCount: Variable<String> = Variable("Init")
    public let artistName: Variable<String> = Variable("Init")
    public let listenersCount: Variable<String> = Variable("Init")

    let service: AlbumDetailService

    // MARK: - Init
    init(service: AlbumDetailService) {
        self.service = service
    }

    // MARK: - Public Methods
    func getAlbumDetail() {
        self.loading.onNext(true)
        service.getAlbumDetail(withAlbumName: album.name, artistName: album.artist.name).bind { [weak self] albumDetailResponse in

            let album = albumDetailResponse.album
            self?.albumName.value = album.name
            if let wikiData = albumDetailResponse.album.wiki {
                self?.publishDate.value = "Publish Date: \(wikiData.published)"
            } else {
                self?.publishDate.value = "Publish Date: N/a"
            }
            self?.artistName.value = "Artist: \(albumDetailResponse.album.artist)"
            self?.listenersCount.value = "Listeners Count: \(albumDetailResponse.album.listeners)"
            self?.tracksCount.value = "Tracks Count: \(albumDetailResponse.album.tracks.track.count)"

            self?.loading.onNext(false)
            }.disposed(by: disposeBag)
    }

    func setupAlbum(_ album: Album) {
        self.album = album
    }


    //    init(album: Album) {
    //        self.album = album
    //        self.albumName = album.name
    //        self.albumImageURL = URL(string:album.image[AlbumCellViewConstants.imageElement].imageURLString)
    //        self.publishDate = ""
    //        self.artists = []
    //        self.listeners = []
    //    }

    

}
