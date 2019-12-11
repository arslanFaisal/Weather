//
//  ImageServiceTest.swift
//  WeatherTests
//
//  Created by Arslan Faisal on 30/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import XCTest
@testable import Weather

class ImageServiceTest: XCTestCase {

    var imageService: ImageService!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        imageService = ImageService(NetworkHandler())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        imageService = nil
    }

    func testImageFetch() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let imageReceivedPromise = expectation(description: "Data is received Successfully")
        imageService.fetchImage("01d") { (image, error) in
            imageReceivedPromise.fulfill()
            XCTAssertNil(error, error?.description ?? "Recieved some error")
            XCTAssertNotNil(image, "image API response is nil")
        }
        wait(for: [imageReceivedPromise], timeout: 3.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            testImageFetch()
        }
    }

}
