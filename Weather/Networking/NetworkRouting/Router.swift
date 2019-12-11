//
//  Router.swift
//  Weather
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

typealias NetworkCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

/// Provides interface for network routing and defines an associated type *EndPoint* confirming to *EndPointType* protocol
protocol Router{
    
    associatedtype EndPoint: EndPointType
    
    @discardableResult
    func request(endPoint: EndPoint, completion: @escaping NetworkCompletion) -> URLSessionTask?
}
