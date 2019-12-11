//
//  HTTPParameterEncoder.swift
//  Weather
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

typealias HTTPParameters = [String:Any]

/// Defines encoding error states
enum EncodingError: String,Error {
    case encodingFailed     = "HTTP parameters are nil"
    case encodeURLMissing   = "url to encode is nil"
}

/// Defines interface for url query string parameters encoding
protocol HTTPParameterEncoder {
    
    /// Encodes URLRequest with the passed url query string parameters
    /// - Parameter urlRequest: Reference to the URLRequest to be modified with passed parameters
    /// - Parameter httpParameters: query string parameters to be endoded with url request
    static  func encode(urlRequest: inout URLRequest, httpParameters: HTTPParameters) throws
}
