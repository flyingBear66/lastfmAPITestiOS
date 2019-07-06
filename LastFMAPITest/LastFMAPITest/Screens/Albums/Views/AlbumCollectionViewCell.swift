//
//  AlbumCollectionViewCell.swift
//  LastFMAPITest
//
//  Created by Ozgun Emre Zor on 05/07/2019.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import UIKit
import AlamofireImage

class AlbumCollectionViewCell: LTFMCollectionViewCell {

    // MARK: - UIControls
    let albumImageView: LTFMImageView = {
        let imageView = LTFMImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let albumNameLabel: LTFMLabel = {
        let label = LTFMLabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    // MARK: - Variables
    var viewModel: AlbumCellViewModel! {
        didSet {
            updateUI()
        }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    func setupViews() {

        backgroundColor = .blue
        clipsToBounds = true
        layer.cornerRadius = CGFloat(AlbumCellViewConstants.cornerRadius)

        addSubview(albumImageView)
        addSubview(albumNameLabel)
        albumImageView.addConstraints([equal(self, \.topAnchor),
                                      equal(self, \.bottomAnchor),
                                      equal(self, \.leadingAnchor),
                                      equal(self, \.trailingAnchor)])
        albumNameLabel.addConstraints([equal(self, \.centerXAnchor),
                                      equal(self, \.centerYAnchor, constant: frame.height / 5),
                                      equal(self, \.leadingAnchor, constant: AlbumCellViewConstants.leading),
                                      equal(self, \.trailingAnchor, constant: AlbumCellViewConstants.trailing)])
    }

    func updateUI() {
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.black,
            .foregroundColor : UIColor.white,
            .strokeWidth : AlbumCellViewConstants.strokeWidth
        ]
        self.albumNameLabel.attributedText = NSAttributedString(string: self.viewModel.albumName, attributes: strokeTextAttributes)

        guard let imageURL = self.viewModel.albumImageURL else {
            return
        }

        self.albumImageView.af_setImage(withURL: imageURL ,
                                        placeholderImage: nil,
                                        filter: nil,
                                        progress: nil,
                                        progressQueue: DispatchQueue.main,
                                        imageTransition: .crossDissolve(0.3),
                                        runImageTransitionIfCached: false,
                                        completion: nil)
    }
}
