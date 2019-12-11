//
//  EndPointType.swift
//  Weather
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

/// Defines Endpoint to provide required properties for any API endpoint
protocol EndPointType {
    var baseURL         : URL { get }
    var path            : String { get }
    var httpMethod      : HTTPMethod { get }
    var task            : HTTPTask { get }
    var cachingPolicy   : URLRequest.CachePolicy { get }
}
