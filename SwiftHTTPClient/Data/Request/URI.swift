//
//  URI.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/11.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation

public struct URI: CustomStringConvertible {
    public enum Scheme: String {
        case http
        case https
    }
    
    public struct Authority: CustomStringConvertible {
        public var userinfo: String?
        public var host: String
        public var port: Int?
        
        public var description: String {
            return "\(userinfo.map { "\($0)@" } ?? "")\(host)\(port.map { ":\($0)" } ?? "")"
        }
        
        public init(userinfo: String? = nil, host: String, port: Int? = nil) {
            self.userinfo = userinfo
            self.host = host
            self.port = port
        }
    }
    
    public struct Query {
        public struct Parameter {
            public var name: String
            public var value: String
            
            public init(name: String, value: String) {
                self.name = name
                self.value = value
            }
        }
        
        public var parameters: [Parameter]
        public var string: String {
            return parameters.reduce("", { (result, parameter) in
                return "\(result)&\(parameter.name)=\(parameter.value)"
            })
        }
        
        public init(parameters: [Parameter]) {
            self.parameters = parameters
        }
    }
    
    public var scheme: Scheme
    public var authority: Authority
    public var path: String
    public var query: Query?
    
    public var host: String {
        return self.authority.host
    }
    
    public var description: String {
        return "\(self.scheme.rawValue)://\(self.authority.description)\(self.path)\(self.query.map { "?\($0)" } ?? "")"
    }
    
    public var url: URL? {
        var urlComponents: URLComponents = .init()
        
        urlComponents.scheme = self.scheme.rawValue
        urlComponents.host = self.authority.description
        urlComponents.path = self.path
        urlComponents.queryItems = self.query?.parameters.map { (parameter) in
            return .init(name: parameter.name, value: parameter.value)
        }
        
        return urlComponents.url
    }
    
    public init(scheme: Scheme, authority: Authority, path: String, query: Query? = nil) {
        self.scheme = scheme
        self.authority = authority
        self.path = path
        self.query = query
    }
    
    public init(scheme: Scheme, host: String, path: String, query: Query? = nil) {
        self.scheme = scheme
        self.authority = .init(host: host)
        self.path = path
        self.query = query
    }
}
