//
//  Navigation.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/4/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Swinject
import UIKit

class Navigation {
    
    // MARK: - Private
    public var navigationController: LTFMNavigationController
    private var window: LTFMWindow
    private var currentViewController: LTFMViewController!
    
    let container = Container()
    
    // MARK: - Lifecycle
    init(window: LTFMWindow) {
        self.navigationController = LTFMNavigationController()
        self.window = window
        
        registerApp()
    }
}

// MARK: - Public
extension Navigation {
    func getCurrentView() -> UIView {
        
        guard let topView = navigationController.topViewController?.view else {
            return LTFMView()
        }
        
        return topView
    }
    
    func openFirstScreenAlbumList() {
        openAlbumList()
    }
    
}

// MARK: - Private
extension Navigation {
    
    // MARK: Album List
    private func openAlbumList() {
        currentViewController = container.resolve(AlbumListViewController.self)!
        navigateTo(viewContoller: currentViewController!, AlbumListViewController.self)
    }

    // MARK: Album Detail
    private func openAlbumDetail(withAlbum album: Album) {
        let viewController: AlbumDetailViewController = container.resolve(AlbumDetailViewController.self)!

        viewController.setupViewModel(withAlbum: album)
        currentViewController = viewController

        pushTo(viewContoller: currentViewController!, AlbumDetailViewController.self)
    }
    
}

// MARK: - Navigate methods
extension Navigation {
    
    private func showInWindow<T: LTFMViewController>(viewContoller: Any, _:T.Type) {
        self.window.rootViewController = (viewContoller as! T)
        self.window.makeKeyAndVisible()
    }
    
    private func navigateTo<T: LTFMViewController>(viewContoller: Any, _:T.Type) {
        self.navigationController = LTFMNavigationController(rootViewController: (viewContoller as! T))
        self.window.rootViewController = (viewContoller as! T).navigationController
    }
    
    private func pushTo<T: LTFMViewController>(viewContoller: Any, _:T.Type) {
        self.navigationController.pushViewController((viewContoller as! T), animated: true)
    }
    
    private func present<T: LTFMViewController>(viewContoller: Any, _:T.Type,
                                              animated: Bool = true, completion: (() -> Void)?) {
        present(viewContoller: viewContoller, T.self, withNavigationController: false, animated: animated, completion: completion)
    }
    
    private func present<T: LTFMViewController>(viewContoller: Any, _:T.Type, withNavigationController: Bool,
                                              animated: Bool = true, completion: (() -> Void)?) {
        let topViewController = self.navigationController.topViewController as! LTFMViewController
        
        if withNavigationController {
            topViewController.present(LTFMNavigationController(rootViewController: (viewContoller as! T)), animated: animated, completion: completion)
        } else {
            topViewController.present((viewContoller as! T), animated: animated, completion: completion)
        }
    }
}

// MARK: - Swifject methods
extension Navigation {
    
    private func registerApp() {
        registerHTTPClient()
        registerAlbumList()
        registerAlbumDetail()
    }
    
    private func registerHTTPClient() {
        // Networking Client
        container.register(AlamofireHTTPClient.self) { _ in AlamofireHTTPClient(apiKey: "9619b9c2e277142fe3eef5e33bc58ac1")}
    }
    
    private func registerAlbumList() {
        // Services
        container.register(AlbumListService.self) { r in AlbumListService(lastFMAPIClient: r.resolve(AlamofireHTTPClient.self)!)}
        
        // ViewModels
        container.register(AlbumListViewModel.self) { r in
            let viewModel = AlbumListViewModel(service: r.resolve(AlbumListService.self)!)

            viewModel.showAlbumDetail = { [unowned self] album in
                self.openAlbumDetail(withAlbum: album)
            }

            return viewModel
        }
        
        // ViewController
        container.register(AlbumListViewController.self) { r in AlbumListViewController(viewModel: r.resolve(AlbumListViewModel.self)!)}
    }
    
    private func registerAlbumDetail() {
        // Services
        container.register(AlbumDetailService.self) { r in AlbumDetailService(lastFMAPIClient: r.resolve(AlamofireHTTPClient.self)!)}

        // ViewModels
        container.register(AlbumDetailViewModel.self) { r in AlbumDetailViewModel(service: r.resolve(AlbumDetailService.self)!)}

        // ViewControllers
        container.register(AlbumDetailViewController.self) { r in AlbumDetailViewController(viewModel: r.resolve(AlbumDetailViewModel.self)!)}
    }

}

