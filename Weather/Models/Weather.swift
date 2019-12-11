//
//  Weather.swift
//  Weather
//
//  Created by Arslan Faisal on 28/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

/// Holds the properties of a *Weather* object of  Open Weather API and confirms to *Decodable* protocol
struct Weather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
