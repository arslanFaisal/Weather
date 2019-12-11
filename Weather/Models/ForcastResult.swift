//
//  ForcastResult.swift
//  Weather
//
//  Created by Arslan Faisal on 28/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

/// Holds the properties of Open Weather API response object and confirms to *Decodable* protocol
struct ForcastResult: Decodable {
    let cod: String?
    let cnt: Int?
    var list: [Forcast?]?
    let city: City?
}
