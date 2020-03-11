//
//  AnyHTTPRequest.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public struct AnyHTTPRequest<Response: HTTPResponse>: HTTPRequest {
    public var host: URL
    public var path: String
    public var method: HTTPRequestMethod
    public var headerFields: [HTTPHeaderField]
    public var body: Data?
    
    public init(host: URL, path: String, method: HTTPRequestMethod = .get, headerFields: [HTTPHeaderField] = [], body: Data? = nil) {
        self.host = host
        self.path = path
        self.method = method
        self.headerFields = headerFields
        self.body = body
    }
    
    public init<Request: HTTPRequest>(_ request: Request) {
        self.init(host: request.host, path: request.path, method: request.method, headerFields: request.headerFields, body: request.body)
    }
}
