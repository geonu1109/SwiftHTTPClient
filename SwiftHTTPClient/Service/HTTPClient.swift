//
//  HTTPClient.swift
//  SwiftHTTPClient
//
//  Created by Geonu Jeon on 2020/03/03.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

public class HTTPClient: HTTPClientType {
    private let urlSession: URLSession
    private let retryCount: Int
    
    public required init(timeoutInterval: TimeInterval = 60, retryCount: Int = 0) {
        let urlSessionConfiguration: URLSessionConfiguration = .default
        urlSessionConfiguration.timeoutIntervalForRequest = timeoutInterval
        self.urlSession = .init(configuration: urlSessionConfiguration)
        
        self.retryCount = retryCount
    }
    
    public func submit<Request: HTTPRequest>(_ request: Request) -> AnyPublisher<Request.Response, Error> {
        let urlRequest: URLRequest = self.createURLRequest(from: request)
        
        return self.dataTaskPublisher(for: urlRequest)
            .tryMap {
                try self.createResponse(Request.Response.self, from: $0)
            }
            .eraseToAnyPublisher()
    }
    
    public func get<Response: HTTPResponse>(_ type: Response.Type, from url: URL) -> AnyPublisher<Response, Error> {
        let request: AnyHTTPRequest<Response> = .init(url: url)
        
        return self.submit(request)
    }
    
    private func dataTaskPublisher(for urlRequest: URLRequest) -> URLSession.DataTaskPublisher {
        return self.urlSession.dataTaskPublisher(for: urlRequest)
    }
    
    private func createURLRequest<Request: HTTPRequest>(from httpRequest: Request) -> URLRequest {
        var urlRequest: URLRequest = .init(url: httpRequest.url)
        
        urlRequest.httpMethod = httpRequest.method.description
        
        httpRequest.headerFields.forEach { (headerField) in
            urlRequest.addValue(headerField.value, forHTTPHeaderField: headerField.name)
        }
        
        urlRequest.httpBody = httpRequest.body
        
        return urlRequest
    }
    
    private func createResponse<Response: HTTPResponse>(_ type: Response.Type, from output: URLSession.DataTaskPublisher.Output) throws -> Response {
        guard let httpURLResponse: HTTPURLResponse = output.response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        let headerFields: [HTTPHeaderField] = httpURLResponse.allHeaderFields.compactMap { (name, value) in
            guard let name: String = name as? String, let value: String = value as? String else {
                return nil
            }
            return .init(name: name, value: value)
        }
        return .init(statusCode: httpURLResponse.statusCode, headerFields: headerFields, body: output.data)
    }
}
