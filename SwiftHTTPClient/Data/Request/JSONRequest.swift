//
//  JSONRequest.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public protocol JSONRequest: HTTPRequest {
    associatedtype Object: Encodable
    
    var object: Object? { get }
}

public extension JSONRequest {
    var body: Data? {
        return self.object.flatMap { (object) in
            return try? JSONEncoder().encode(object)
        }
    }
}
