//
//  AlbumListViewController.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/5/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import EmptyDataSet_Swift

class AlbumListViewController: LTFMViewController {

    // MARK: - UIControls
    let collectionView: AlbumCollectionView = {
        let collectionView = AlbumCollectionView()
        return collectionView
    }()

    // MARK: - Variables
    let viewModel: AlbumListViewModel
    
    // MARK: - View LifeCycle
    init(viewModel: AlbumListViewModel) {
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
        title = "Top 100"
        view.backgroundColor = .white

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.emptyDataSetSource = self
        view.addSubview(collectionView)

        collectionView.addConstraints(equalToSuperview())
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

        // observe Repo changes
        // binding repos to view
        viewModel
            .albumCellViewModels
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.collectionView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.getAlbums()
    }
}

extension AlbumListViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.albumCellViewModels.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = viewModel.albumCellViewModels.value[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCellIdentifiers.albumCell, for: indexPath) as! AlbumCollectionViewCell
        cell.viewModel = cellViewModel
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.openScreen(withSelectedIndexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !self.loading && indexPath.row == viewModel.albumCellViewModels.value.count - 2 {
            viewModel.getAlbums()
        }
    }
}

extension AlbumListViewController: EmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "No Albums :(")
    }
}
