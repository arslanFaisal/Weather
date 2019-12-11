//
//  City.swift
//  Weather
//
//  Created by Arslan Faisal on 30/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

/// Holds the properties of a *City* object of  Open Weather API and confirms to *Decodable* protocol
struct City: Decodable {
    let id: Int?
    let name: String?
    let country: String?
}
