//
//  WeatherServiceTest.swift
//  WeatherTests
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherServiceTest: XCTestCase {

    var weatherService: WeatherService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        weatherService = WeatherServiceFactory.weatherService(NetworkHandler())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        weatherService = nil
    }

    func testForcastFetch() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let forcastReceivedPromise = expectation(description: "Data is received Successfully")
        var cityID: String? = nil
        if let cityId = WeatherAPIKey.defaultCity.id {
            cityID = String(cityId)
        }
        weatherService.fetchWeatherForCity(cityID) { (forcastResult, error) in
            forcastReceivedPromise.fulfill()
            XCTAssertNil(error, error ?? "Recieved some error")
            XCTAssertNotNil(forcastResult, "weather API response is nil")
            if let count = forcastResult?.list?.count {
                XCTAssertGreaterThan(count, 0, "forcasts list is empty")
            }
        }
        wait(for: [forcastReceivedPromise], timeout: 3.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            testForcastFetch()
        }
    }

}
