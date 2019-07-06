//
//  AlbumCollectionView.swift
//  LastFMAPITest
//
//  Created by Ozgun Emre Zor on 05/07/2019.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import UIKit

class AlbumCollectionView: LTFMCollectionView {

    init() {
        let heroCollectionViewLayout = AlbumCollectionViewLayout()
        super.init(frame: .zero, collectionViewLayout: heroCollectionViewLayout)
        backgroundColor = .clear
        register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCellIdentifiers.albumCell)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
