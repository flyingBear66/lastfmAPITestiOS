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
    public var album: Album?
    public var albumDetail: AlbumDetail?

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
        guard let album = self.album else {
            self.error.onNext(.internalError("Album is not initilized correctly"))
            self.loading.onNext(false)
            return
        }

        service.getAlbumDetail(withAlbumName: album.name, artistName: album.artist.name).bind { [weak self] albumDetailResponse in

            guard let albumDetail = albumDetailResponse.album else {
                self?.error.onNext(.internalError("AlbumDetail is not fetched correctly"))
                self?.loading.onNext(false)
                return
            }

            self?.albumDetail = albumDetail

            self?.albumName.value = albumDetail.name
            if let wikiData = albumDetail.wiki {
                self?.publishDate.value = "Publish Date: \(wikiData.published)"
            } else {
                self?.publishDate.value = "Publish Date: N/a"
            }
            self?.artistName.value = "Artist: \(albumDetail.artist)"
            self?.listenersCount.value = "Listeners Count: \(albumDetail.listeners)"
            self?.tracksCount.value = "Tracks Count: \(albumDetail.tracks.track.count)"

            self?.loading.onNext(false)
        }.disposed(by: disposeBag)
    }

    func setupAlbum(_ album: Album) {
        self.album = album
    }
    
}
