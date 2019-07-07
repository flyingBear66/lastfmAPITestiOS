//
//  AlbumDetailViewController.swift
//  LastFMAPITest
//
//  Created by Ozgun Emre Zor on 07/07/2019.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumDetailViewController: LTFMViewController {

    // MARK: - UIControls
    let albumNameLabel: LTFMLabel = {
        let label = LTFMLabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        label.text = "N/a"
        return label
    }()

    let artistTitleLabel: LTFMLabel = {
        let label = LTFMLabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.text = "N/a"
        return label
    }()

    let tracksCountLabel: LTFMLabel = {
        let label = LTFMLabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.text = "N/a"
        return label
    }()

    let publishDateLabel: LTFMLabel = {
        let label = LTFMLabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.text = "N/a"
        return label
    }()

    let listenersCountLabel: LTFMLabel = {
        let label = LTFMLabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.text = "N/a"
        return label
    }()

    // MARK: - Variables
    let viewModel: AlbumDetailViewModel

    func setupViewModel(withAlbum album: Album) {
        self.viewModel.setupAlbum(album)
    }

    // MARK: - View LifeCycle
    init(viewModel: AlbumDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
    }

    // MARK: - Helpers
    private func setupViews() {
        // View
        title = "Album Detail"
        view.backgroundColor = .white

        self.view.addSubview(albumNameLabel)
        self.view.addSubview(tracksCountLabel)
        self.view.addSubview(publishDateLabel)
        self.view.addSubview(artistTitleLabel)
        self.view.addSubview(listenersCountLabel)

        albumNameLabel.addConstraints([equal(self.view, \.topAnchor, constant: self.view.frame.height / 6),
                                       equal(self.view, \.leadingAnchor, constant: AlbumViewConstants.leading),
                                       equal(self.view, \.trailingAnchor, constant: AlbumViewConstants.trailing),
                                       equal(artistTitleLabel, \.bottomAnchor, \.topAnchor, constant: 0)])

        artistTitleLabel.addConstraints([equal(self.view, \.leadingAnchor, constant: AlbumViewConstants.leading),
                                         equal(self.view, \.trailingAnchor, constant: AlbumViewConstants.trailing),
                                         equal(tracksCountLabel, \.bottomAnchor, \.topAnchor, constant: 0)])

        tracksCountLabel.addConstraints([equal(self.view, \.leadingAnchor, constant: AlbumViewConstants.leading),
                                         equal(self.view, \.trailingAnchor, constant: AlbumViewConstants.trailing),
                                         equal(publishDateLabel, \.bottomAnchor, \.topAnchor, constant: 0)])

        publishDateLabel.addConstraints([equal(self.view, \.leadingAnchor, constant: AlbumViewConstants.leading),
                                         equal(self.view, \.trailingAnchor, constant: AlbumViewConstants.trailing),
                                         equal(listenersCountLabel, \.bottomAnchor, \.topAnchor, constant: 0)])


        listenersCountLabel.addConstraints([equal(self.view, \.leadingAnchor, constant: AlbumViewConstants.leading),
                                         equal(self.view, \.trailingAnchor, constant: AlbumViewConstants.trailing)])

    }

    private func setupViewModel() {
        // observing loading state
        viewModel
            .loading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { loading in
                if loading {
                    self.showLoadingIndicator()
                } else {
                    self.hideLoadingIndicator()
                }
            }).disposed(by: disposeBag)

        // observing errors to show
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { error in
                switch error {
                case .internalError(let message):
                    print("Internal Error \(message)")
                case .serverError(let message):
                    print("Server Error \(message)")
                }
            })
            .disposed(by: disposeBag)

        // Observing properties
        self.viewModel.albumName
            .asObservable()
            .map { $0 }
            .bind(to:self.albumNameLabel.rx.text)
            .disposed(by:self.disposeBag)

        self.viewModel.artistName
            .asObservable()
            .map { $0 }
            .bind(to:self.artistTitleLabel.rx.text)
            .disposed(by:self.disposeBag)
        
        self.viewModel.publishDate
            .asObservable()
            .map { $0 }
            .bind(to:self.publishDateLabel.rx.text)
            .disposed(by:self.disposeBag)

        self.viewModel.tracksCount
            .asObservable()
            .map { $0 }
            .bind(to:self.tracksCountLabel.rx.text)
            .disposed(by:self.disposeBag)

        self.viewModel.listenersCount
            .asObservable()
            .map { $0 }
            .bind(to:self.listenersCountLabel.rx.text)
            .disposed(by:self.disposeBag)

        self.viewModel.getAlbumDetail()
    }
}
