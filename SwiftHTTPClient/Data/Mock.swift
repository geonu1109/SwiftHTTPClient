//
//  Mock.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/05.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public class Mock {
    public let data: Data
    
    public init(_ data: Data) {
        self.data = data
    }
    
    public convenience init<Object: Encodable>(from object: Object) throws {
        let data: Data = try JSONEncoder().encode(object)
        self.init(data)
    }
    
    public convenience init(from url: URL) throws {
        let data: Data = try Data(contentsOf: url, options: .mappedIfSafe)
        self.init(data)
    }
    
    public convenience init(from filename: String, with fileExtension: String) throws {
        guard let url: URL = Bundle.main.url(forResource: filename, withExtension: fileExtension) else {
            throw URLError(.fileDoesNotExist)
        }
        try self.init(from: url)
    }
}
