//
//  HTTPResponse.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public protocol HTTPResponse: CustomDebugStringConvertible {
    var statusCode: Int { get }
    var headerFields: [HTTPHeaderField] { get }
    var body: Data? { get }
    
    init(statusCode: Int, headerFields: [HTTPHeaderField], body: Data?)
}

public extension HTTPResponse {
    var status: HTTPResponseStatus {
        return .create(from: self.statusCode)
    }
    
    static func createMock(_ mock: Mock, headerFields: [HTTPHeaderField] = [], statusCode: Int) -> Self {
        return .init(statusCode: statusCode, headerFields: headerFields, body: mock.data)
    }
    
    var debugDescription: String {
        return """
            [HTTP Response]
              Status Code: \(self.statusCode.description)
              Header Fields: \(self.headerFields.count == 0 ? "empty" : "\n\(self.headerFields.map { "    \($0.name): \($0.value)" }.joined(separator: "\n"))")
              Body: \(self.body.map { String(data: $0, encoding: .utf8) ?? $0.base64EncodedString() } ?? "empty")
            """
    }
    
    func asAnyHTTPResponse() -> AnyHTTPResponse {
        return .init(self)
    }
}
