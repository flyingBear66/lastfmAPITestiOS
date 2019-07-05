//
//  LTFMMViewModel.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/4/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import RxSwift

public enum HomeError {
    case internalError(String)
    case serverError(String)
}

class LTFMViewModel {
    public let error: PublishSubject<HomeError> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let disposeBag = DisposeBag()
}
