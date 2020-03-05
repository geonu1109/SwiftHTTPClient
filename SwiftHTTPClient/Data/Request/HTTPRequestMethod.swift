//
//  HTTPRequestMethod.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public enum HTTPRequestMethod: String, Equatable, CustomStringConvertible {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case trace = "TRACE"
    case options = "OPTIONS"
    case connect = "CONNECT"
    case patch = "PATCH"
    case unknown = "Unknown"
    
    public var description: String {
        return self.rawValue
    }
    
    public static func create(from text: String) -> HTTPRequestMethod {
        return HTTPRequestMethod(rawValue: text.uppercased()) ?? .unknown
    }
}
