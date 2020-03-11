//
//  SwiftHTTPClientTests.swift
//  SwiftHTTPClientTests
//
//  Created by Geonu Jeon on 2020/03/11.
//  Copyright © 2020 Geonu Jeon. All rights reserved.
//

import XCTest
@testable import SwiftHTTPClient

struct GitHubRepo: Codable {
    let id: Int
    let name: String
    let `private`: Bool
}

class SwiftHTTPClientTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGitHubUserRepos() {
        // given
        let uri: URI = .init(scheme: .https, host: "api.github.com", path: "/users/geonu1109/repos", query: .init(parameters: [
            .init(name: "sort", value: "created")
        ]))
        
        let request: AnyHTTPRequest<AnyHTTPResponse> = .init(url: uri.url!, method: .get)
        
        print("request url: \(request.url.absoluteString)")
        
        let testExpectation = expectation(description: "Waiting for getting github user repos task...")
        
        var result: Bool = false
        
        // when
        let cancellable = HTTPClient().submit(request)
            .sink(receiveCompletion: { (completion) in
                testExpectation.fulfill()
            }) { (response) in
                guard let body = response.body else {
                    print("response body is nil")
                    return
                }
                do {
                    let repos = try JSONDecoder().decode(Array<GitHubRepo>.self, from: body)
                    if repos.filter({ $0.name == "SwiftHTTPClient" }).count > 0 {
                        result = true
                    }
                    else {
                        print("SwiftHTTPClient is not found")
                    }
                }
                catch {
                    print("json decoding error: \(error.localizedDescription)")
                }
            }
        
        // then
        waitForExpectations(timeout: 3, handler: { (error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        })
        
        cancellable.cancel()
        
        XCTAssertTrue(result)
    }
}
