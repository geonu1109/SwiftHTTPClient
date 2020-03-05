//
//  JSONResponse.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public protocol JSONResponse: HTTPResponse {
    associatedtype Object: Decodable
}

public extension JSONResponse {
    var object: Object? {
        return self.body.flatMap { (body) in
            return try? JSONDecoder().decode(Object.self, from: body)
        }
    }
}
