//
//  TestUtility.swift
//  WeatherTests
//
//  Created by Arslan Faisal on 02/12/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
@testable import Weather

struct TestUtility {
    private init() {}
    
    static func testTemprature() -> String {
        var tempratureString = "67.06"
        let locale = NSLocale.current as NSLocale
        if let unitStr = locale.object(forKey: NSLocale.Key(rawValue: NotificationNames.kCFLocaleTemperatureUnitKey)) as? String, unitStr.lowercased() == "celsius" {
            tempratureString = "19.48"
        }
        return tempratureString
    }
}

