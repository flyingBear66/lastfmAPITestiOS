//
//  LTFMViewController+ActivityIndicator.swift
//  LastFMAPITest
//
//  Created by Ozgun Emre Zor on 07/07/2019.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Foundation

import SVProgressHUD
import UIKit

extension LTFMViewController {

    public func showLoadingIndicator() {
        SVProgressHUD.show()
    }

    public func hideLoadingIndicator() {
        SVProgressHUD.dismiss()
    }

}
