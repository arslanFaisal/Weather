//
//  WeatherCollectionCellViewModelTest.swift
//  WeatherTests
//
//  Created by Arslan Faisal on 01/12/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherCollectionCellViewModelTest: XCTestCase {

    var weatherService: WeatherService!
    var viewModel: WeatherCollectionCellViewModel!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        weatherService = WeatherServiceFactory.weatherService(nil)
        viewModel = WeatherCollectionCellViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        weatherService = nil
        viewModel = nil
    }

    func testForcastTempAndTime() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let forcastReceivedPromise = expectation(description: "Data is received Successfully")
        weatherService.fetchWeatherForCity(nil) { [weak self] (forcastResult, error) in
            forcastReceivedPromise.fulfill()
            XCTAssertFalse(forcastResult?.list?.isEmpty ?? true, "Failed to load json")
            if let forcast = forcastResult?.list?.first, let sureSelf = self {
                self?.viewModel.forcast = forcast
                XCTAssertEqual(sureSelf.viewModel.forcastTemprature, TestUtility.testTemprature() + " " + Utility.getUserTempUnitSymbol())
                XCTAssertEqual(sureSelf.viewModel.forcastTime, "9:00 AM")
            }
        }
        wait(for: [forcastReceivedPromise], timeout: 3.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
