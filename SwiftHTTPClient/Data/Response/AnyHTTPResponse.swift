//
//  AnyHTTPResponse.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public struct AnyHTTPResponse: HTTPResponse {
    public let statusCode: Int
    public let headerFields: [HTTPHeaderField]
    public let body: Data?
    
    public init(statusCode: Int, headerFields: [HTTPHeaderField], body: Data?) {
        self.statusCode = statusCode
        self.headerFields = headerFields
        self.body = body
    }
    
    public init<Response: HTTPResponse>(_ response: Response) {
        self.init(statusCode: response.statusCode, headerFields: response.headerFields, body: response.body)
    }
}
