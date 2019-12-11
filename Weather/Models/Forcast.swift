//
//  Forcast.swift
//  Weather
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

/// Holds the properties of a *Forcast* object from Open Weather API and confirms to *Decodable* protocol
struct Forcast: Decodable {
    let dateInterval: Int?
    let date: Date?
    var weatherParticular: WeatherParticular?
    let weather: [Weather?]?
    
    enum CodingKeys: String, CodingKey {
        case dateInterval = "dt"
        case date  = "dtTxt"
        case weatherParticular = "main"
        case weather
    }
}
