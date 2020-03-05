//
//  HTTPClientType.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation
import Combine

public protocol HTTPClientType {
    init(timeoutInterval: TimeInterval, retryCount: Int)
    
    func submit<Request: HTTPRequest>(_ request: Request) -> AnyPublisher<Request.Response, Error>
}
