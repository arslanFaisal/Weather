//
//  WeatherParticular.swift
//  Weather
//
//  Created by Arslan Faisal on 28/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

/// Holds the properties of a *WeatherParticular* object of Open Weather API and confirms to *Decodable* protocol
struct WeatherParticular: Decodable {
    var temp: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Double?
    let seaLevel: Double?
    let humidity: Double?
    
    mutating func updateTemp(_ temprature:  Double?) {
        temp = temprature
    }
}
