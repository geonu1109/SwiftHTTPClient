//
//  JSONResponse.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public protocol JSONResponse: HTTPResponse {
    associatedtype BodyObject: Decodable
}

public extension JSONResponse {
    var bodyObject: BodyObject? {
        return self.body.flatMap { (body) in
            return try? JSONDecoder().decode(BodyObject.self, from: body)
        }
    }
}
