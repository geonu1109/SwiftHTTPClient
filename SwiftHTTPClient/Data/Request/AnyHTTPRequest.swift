//
//  AnyHTTPRequest.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public struct AnyHTTPRequest<Response: HTTPResponse>: HTTPRequest {
    public var uri: URL
    public var method: HTTPRequestMethod
    public var headerFields: [HTTPHeaderField]
    public var body: Data?
    
    public init(uri: URL, method: HTTPRequestMethod = .get, headerFields: [HTTPHeaderField] = [], body: Data? = nil) {
        self.uri = uri
        self.method = method
        self.headerFields = headerFields
        self.body = body
    }
    
    public init<Request: HTTPRequest>(_ request: Request) {
        self.init(uri: request.uri, method: request.method, headerFields: request.headerFields, body: request.body)
    }
}
