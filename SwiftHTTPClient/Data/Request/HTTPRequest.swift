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
    
    var host: URL { get }
    var path: String { get }
    var method: HTTPRequestMethod { get }
    var headerFields: [HTTPHeaderField] { get }
    var body: Data? { get }
}

public extension HTTPRequest {
    var uri: URL {
        return self.host.appendingPathComponent(self.path)
    }
    
    func asAnyHTTPRequest() -> AnyHTTPRequest<Response> {
        return .init(self)
    }
}
