//
//  AlamofireHTTPClient.swift
//  LastFMAPITest
//
//  Created by Ozgun Zor on 7/5/19.
//  Copyright © 2019 Ozgun Zor. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift

protocol ClientProtocol {
    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response>
}

final class AlamofireHTTPClient: ClientProtocol {
    private let manager: Alamofire.SessionManager
    private let baseURL = URL(string: "http://ws.audioscrobbler.com/2.0")!
    private let jsonURL = URL(string: "&format=json")!
    
    private let queue = DispatchQueue(label: "httpsQueue")
    
    private let apiKey: String?
    private let sharedSecret: String?
    
    init(accessToken: String) {
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        defaultHeaders["Authorization"] = "Bearer \(accessToken)"
        
        let configuration = URLSessionConfiguration.default
        
        // Add `Auth` header to the default HTTP headers set by `Alamofire`
        configuration.httpAdditionalHeaders = defaultHeaders
        
        self.apiKey = nil
        self.sharedSecret = nil
        
        self.manager = Alamofire.SessionManager(configuration: configuration)
    }

    public init(apiKey: String, sharedSecret: String) {
        self.apiKey = apiKey
        self.sharedSecret = sharedSecret
        self.manager = Alamofire.SessionManager(configuration: .default)
    }
    
    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response> {
        return Single<Response>.create { observer in
            let request = self.manager.request(
                self.url(path: endpoint.path),
                method: httpMethod(from: endpoint.method),
                parameters: endpoint.parameters
            )
            request
                .validate()
                .responseData(queue: self.queue) { response in
                    let result = response.result.flatMap(endpoint.decode)
                    switch result {
                    case let .success(val): observer(.success(val))
                    case let .failure(err): observer(.error(err))
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    private func url(path: Path) -> URL {
        return baseURL.appendingPathComponent(path)
    }
}

private func httpMethod(from method: Method) -> Alamofire.HTTPMethod {
    switch method {
    case .get: return .get
    case .post: return .post
    case .put: return .put
    case .patch: return .patch
    case .delete: return .delete
    }
}
