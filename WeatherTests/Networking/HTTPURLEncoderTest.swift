//
//  HTTPURLEncoderTest.swift
//  WeatherTests
//
//  Created by Arslan Faisal on 30/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import XCTest
@testable import Weather

class HTTPURLEncoderTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        var urlRequest = URLRequest(url: URL(string: "www.google.com")!)
        urlRequest.httpMethod = "GET"
        let params = ["param1": "SampleData", "param2": "Sample data 2"]
        do {
            try HTTPURLParameterEncoder.encode(urlRequest: &urlRequest, httpParameters: params)
            XCTAssertTrue((urlRequest.url?.absoluteString == "www.google.com?param2=Sample%2520data%25202&param1=SampleData" || urlRequest.url?.absoluteString == "www.google.com?param1=SampleData&param2=Sample%2520data%25202"), "URL Encoding failed")
        } catch {
            XCTFail("URL Encoding failed")
        }
    }

}
