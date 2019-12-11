//
//  LiveWeatherService.swift
//  Weather
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

typealias WeatherCompletionBlock = (_ forcast: ForcastResult?,_ error: String?)-> ()

/// Service for fetching Weather Forcast from the network
struct LiveWeatherService: WeatherService {
    var networkHandler: NetworkHandler
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}

extension LiveWeatherService: DataModelDecoder {
    
    /// Fetches the list of cras using the *WeatherAPI * *forcast* end point
    /// - Parameter completion: Completion closure with  *ForcastResult*  objects or error string
    func fetchWeatherForCity(_ cityId: String, completion: @escaping WeatherCompletionBlock) {
        networkHandler.fetchData(WeatherAPI.forcast(city: cityId), completion: {(data, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do {
                let forcastResultModel : ForcastResult? = try self.decodeModel(data: data)
                guard let forcastResult = forcastResultModel, let code = forcastResult.cod, code == "200" else {
                    completion(nil, NetworkResponse.failed.rawValue)
                    return
                }
                completion(forcastResult, nil)
            } catch {
                completion(nil, NetworkResponse.unableToDecode.rawValue)
            }
        })
    }
}
