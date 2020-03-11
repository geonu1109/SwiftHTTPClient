//
//  JSONRequest.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public protocol JSONRequest: HTTPRequest {
    associatedtype BodyObject: Encodable
    
    var bodyObject: BodyObject? { get }
}

public extension JSONRequest {
    var body: Data? {
        return self.bodyObject.flatMap { (object) in
            return try? JSONEncoder().encode(object)
        }
    }
}
