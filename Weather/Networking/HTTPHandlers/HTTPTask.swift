//
//  HTTPTask.swift
//  Weather
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

/// Defines request with *HTTPParameters* for  *URLRequest* query parameters
enum HTTPTask {
    case request(urlParams: HTTPParameters?)
}

