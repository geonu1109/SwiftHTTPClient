//
//  HTTPRequest.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public protocol HTTPRequest: CustomDebugStringConvertible {
    associatedtype Response: HTTPResponse
    
    var url: URL { get }
    var method: HTTPRequestMethod { get }
    var headerFields: [HTTPHeaderField] { get }
    var body: Data? { get }
}

public extension HTTPRequest {
    var debugDescription: String {
        return """
            [HTTP Request]
              URI: \(self.url.absoluteString)
              Method: \(self.method.description)
              Header Fields: \(self.headerFields.count == 0 ? "empty" : "\n\(self.headerFields.map { "    \($0.name): \($0.value)" }.joined(separator: "\n"))")
              Body: \(self.body.map { String(data: $0, encoding: .utf8) ?? $0.base64EncodedString() } ?? "empty")
            """
    }
    
    func asAnyHTTPRequest() -> AnyHTTPRequest<Response> {
        return .init(self)
    }
}
