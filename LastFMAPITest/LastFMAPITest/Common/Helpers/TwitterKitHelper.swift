//
//  TwitterKitHelper.swift
//  LastFMAPITest
//
//  Created by Ozgun Emre Zor on 07/07/2019.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Foundation
import TwitterKit

struct TwitterKitHelper {

    static func setupTwitterKit() {
        TWTRTwitter.sharedInstance().start(withConsumerKey: "SuBq4VaXEXcZgWxkvKYPRHfG3", consumerSecret: "YSMt5AgH4klkGgy6tT42TSr7goexEPddjuFLUbVT8j3x2gDVNu")
    }

    static func shareTweet(withViewController viewController: LTFMViewController, album: AlbumDetail?) {
        guard let album = album else {
            return
        }
        
        let composer = TWTRComposer()

        composer.setText("Hey! check this out album on LastFM, \(album.name), \(album.artist)")

        // Called from a UIViewController
            composer.show(from: viewController) { result in
            if (result == .done) {
                print("Successfully composed Tweet")
            } else {
                print("Cancelled composing")
            }
        }
    }
}
