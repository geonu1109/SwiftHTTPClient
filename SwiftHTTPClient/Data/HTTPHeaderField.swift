//
//  HTTPRequestHeaderField.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public struct HTTPHeaderField {
    public var name: String
    public var value: String
    
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}
