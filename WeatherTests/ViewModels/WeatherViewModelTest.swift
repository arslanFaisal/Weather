//
//  WeatherViewModelTest.swift
//  WeatherTests
//
//  Created by Arslan Faisal on 01/12/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherViewModelTest: XCTestCase {

    var weatherService: WeatherService!
    var viewModel: WeatherViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        weatherService = WeatherServiceFactory.weatherService(nil)
        viewModel = WeatherViewModel()
        viewModel.viewType.value = .offline
        
        let forcastReceivedPromise = expectation(description: "Data is received Successfully")
        weatherService.fetchWeatherForCity(nil) { [weak self] (forcastResult, error) in
            forcastReceivedPromise.fulfill()
            self?.viewModel.handlerForcastResponse(forcastResult, error: error)
        }
        wait(for: [forcastReceivedPromise], timeout: 3.0)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        weatherService = nil
        viewModel = nil
    }

    func testForcastMapper() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let firstDate = "2019-12-11".dateFromString()
        let lastDate = "2019-12-16".dateFromString()
        XCTAssertEqual(viewModel.dateWiseForcastArray.value.first?.date, firstDate, "Wrong Date Mapping")
        XCTAssertEqual(viewModel.dateWiseForcastArray.value.last?.date, lastDate, "Wrong Date Mapping")
    }
    func testViewHelpers() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(viewModel.numberOfSections(), 6, "Wrong section count")
        XCTAssertEqual(viewModel.numberOfItemsInSection(0), 5, "Wrong items count")
        XCTAssertEqual(viewModel.forcastAtSection(0, row: 0)?.weatherParticular?.temp?.format(f: "0.2"), TestUtility.testTemprature(), "Wrong Forcast for item")
        XCTAssertEqual(viewModel.titleForView(), Titles.offlineTitle, "Wrong view title")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
