//
//  Application.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/4/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Foundation

class Application {
    
    // MARK: - Dependencies
    private let window: LTFMWindow
    lazy var navigation: Navigation = Navigation(
        window: self.window
    )
    
    // MARK: - Lifecycle
    init(window: LTFMWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
    }
    
}
