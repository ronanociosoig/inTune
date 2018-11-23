//
//  URLParameterEncodingTests.swift
//  NetworkTests
//
//  Created by Ronan on 04/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest

@testable import Network

class URLParameterEncodingTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testURLParameterEncoding() {
        let url = URL(string: "https://some.domain")
        var request = URLRequest(url: url!)
        
        let parameters: Parameters = ["start":"value"]
        let encoder = URLParameterEncoder()
        do {
            try encoder.encode(urlRequest: &request, with: parameters)
        } catch {
            XCTFail()
            return
        }
        let absoluteURL = request.url?.absoluteString
        XCTAssertTrue(absoluteURL == "https://some.domain?start=value")
    }
    
    func testMultipleURLParameterEncoding() {
        let url = URL(string: "https://some.domain")
        var request = URLRequest(url: url!)
        
        let parameters: Parameters = ["currency":"EUR", "start":"value1", "end":"value2"]
        let encoder = URLParameterEncoder()
        do {
            try encoder.encode(urlRequest: &request, with: parameters)
        } catch {
            XCTFail()
            return
        }
        guard let absoluteURL = request.url?.absoluteString else {
            XCTFail()
            return
        }
        
        let parts = absoluteURL.split(separator: "?")
        let params = parts[1].split(separator: "&")
        XCTAssertTrue(params.count == 3)
    }
    
    func testMultipleURLParameterEncodingFailure() {
        let url = URL(string: "https://some.domain")
        var request = URLRequest(url: url!)
        
        let parameters: Parameters = ["currency":"€", "start":"value1", "end":"value2"]
        let encoder = URLParameterEncoder()
        do {
            try encoder.encode(urlRequest: &request, with: parameters)
        } catch {
            XCTFail()
            return
        }
        guard let absoluteURL = request.url?.absoluteString else {
            XCTFail()
            return
        }
        
        let parts = absoluteURL.split(separator: "?")
        let params = parts[1].split(separator: "&")
        
        XCTAssertTrue(params.count == 3)
    }
    
    func testContentTypeHeaderInRequest() {
        let contentTypeValue = "application/x-www-form-urlencoded; charset=utf-8"
        let url = URL(string: "https://some.domain")
        var request = URLRequest(url: url!)
        
        let parameters: Parameters = ["start":"value"]
        let encoder = URLParameterEncoder()
        do {
            try encoder.encode(urlRequest: &request, with: parameters)
        } catch {
            XCTFail()
            return
        }
        
        let headers = request.allHTTPHeaderFields
        let contentTypeFromHeader = headers![encoder.contentTypeKey]
        XCTAssertTrue(contentTypeValue == contentTypeFromHeader, "Header should contain the content type header.")
    }
    
    
}
