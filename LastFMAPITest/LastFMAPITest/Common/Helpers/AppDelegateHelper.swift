//
//  AppDelegateHelper.swift
//  LastFMAPITest
//
//  Created by Ozgun Emre Zor on 05/07/2019.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import AlamofireNetworkActivityLogger
import CocoaLumberjack
import Foundation
import StoreKit

struct AppDelegateHelper {

    static func setupLibrariesOnLaunch() {
        AppDelegateHelper.setupCocoaLumberjackLogger()
        DDLogInfo("Setting Up Libraies on Launch")
        AppDelegateHelper.setupAlamofireNetworkLogger()
    }

    private static func setupCocoaLumberjackLogger() {
        DDLog.add(DDOSLogger.sharedInstance) // Uses os_log
        DDLogInfo("Setting Up Cocoa Lumber Jack Logger")

        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }

    private static func setupAlamofireNetworkLogger() {
        DDLogInfo("Setting Up Alamofire Network Activity Logger")
        NetworkActivityLogger.shared.startLogging()
    }


    static func showAppStoreReviewIfNecessary() {
        var openingCount = UserDefaults.standard.integer(forKey: UserDefaultsKey.appOpeningCount)

        if openingCount == HelperConstants.appOpeningLimitForStoreReview {
            SKStoreReviewController.requestReview()
            openingCount = 0
            UserDefaults.standard.set(openingCount, forKey: UserDefaultsKey.appOpeningCount)
        }
    }

    static func incrementOpeningCount() {
        var openingCount = UserDefaults.standard.integer(forKey: UserDefaultsKey.appOpeningCount)
        openingCount += 1
        UserDefaults.standard.set(openingCount, forKey: UserDefaultsKey.appOpeningCount)
    }
}
