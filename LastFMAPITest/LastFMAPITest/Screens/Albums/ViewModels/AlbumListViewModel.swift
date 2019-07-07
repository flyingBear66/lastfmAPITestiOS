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

protocol AlbumListViewModelEvents {
    var showAlbumDetail: ((Album) -> Void)? {get set}
}

class AlbumListViewModel: LTFMViewModel {

    // MARK: - Events
    var showAlbumDetail: ((Album) -> Void)?

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
            let viewModels = self?.getAlbumCellViewModels(with: albums.albums.album) ?? []
            if !viewModels.isEmpty {
                self?.albumCellViewModels.value += viewModels
            }
            self?.loading.onNext(false)
            }.disposed(by: disposeBag)
    }

    // MARK: - Helper Methods
    func getAlbumCellViewModels(with albums:[Album]) -> [AlbumCellViewModel] {
        return albums.map({ album -> AlbumCellViewModel in
            AlbumCellViewModel(album: album)
        })
    }

    // MARK: - Public Methods
    func openScreen(withSelectedIndexPath selectedIndexPath: IndexPath) {
        let selectedCellViewModel = albumCellViewModels.value[selectedIndexPath.row]
        self.showAlbumDetail!(selectedCellViewModel.album)
    }
    
}
