//
//  AutoCompleteViewModelTest.swift
//  WeatherTests
//
//  Created by Arslan Faisal on 01/12/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import XCTest
@testable import Weather

class AutoCompleteViewModelTest: XCTestCase {

    var viewModel: AutoCompleteViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = AutoCompleteViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testSearchBerl() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let citiesPromise = expectation(description: "Data is received Successfully")
        viewModel.offlineCityService.fetchCities { [weak self] (cities, error) in
            citiesPromise.fulfill()
            if error == nil, let citiesList = cities {
                self?.viewModel.allCities = citiesList
            }
        }
        wait(for: [citiesPromise], timeout: 15.0)
        viewModel.searchLister?("laho")
        XCTAssertTrue(viewModel.cities.value.contains { return $0?.name == "Lahore" })
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
