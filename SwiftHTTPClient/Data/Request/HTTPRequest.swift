//
//  HTTPRequest.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public protocol HTTPRequest {
    associatedtype Response: HTTPResponse
    
    var uri: URL { get }
    var method: HTTPRequestMethod { get }
    var headerFields: [HTTPHeaderField] { get }
    var body: Data? { get }
}

public extension HTTPRequest {
    func asAnyHTTPRequest() -> AnyHTTPRequest<Response> {
        return .init(self)
    }
}
