//
//  AlbumListViewModel.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/5/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumListViewModel: LTFMViewModel {

    // MARK: - Variables
    public let albumCellViewModels: Variable<[AlbumCellViewModel]> = Variable([])

    let service: AlbumListService
    
    // MARK: - Init
    init(service: AlbumListService) {
        self.service = service
    }

    // MARK: - Services
    func getAlbums() {
        self.loading.onNext(true)
        service.getAlbums().bind { [weak self] albums in
            let viewModels = self?.getAlbumCellViewModels(with: albums.albums.album)
            self?.albumCellViewModels.value = viewModels ?? []
            self?.loading.onNext(false)
            }.disposed(by: disposeBag)
    }

    // MARK: - Helper Methods
    func getAlbumCellViewModels(with albums:[Album]) -> [AlbumCellViewModel] {
        return albums.map({ album -> AlbumCellViewModel in
            AlbumCellViewModel(album: album)
        })
    }
    
}
