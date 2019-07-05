//
//  LTFMViewController.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/4/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import CocoaLumberjack
import RxSwift
import UIKit

class LTFMViewController: UIViewController {

    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - View LifeCycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DDLogInfo("\(String(describing: self)) viewDidLoad")
    }

}
