//
//  AlbumListViewController.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/5/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import UIKit

class AlbumListViewController: LTFMViewController {

    // MARK: - UIControls

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
    }
    
    private func setupViewModel() {
        
    }
    
    // MARK: - UIActions

}
