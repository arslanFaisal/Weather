//
//  WeatherService.swift
//  Weather
//
//  Created by Arslan Faisal on 01/12/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

struct WeatherServiceFactory: WeatherService {
    private init() {}
    static func weatherService(_ networkHandler: NetworkHandler?) -> WeatherService {
        guard let handler = networkHandler else { return OfflineWeatherService()}
        return LiveWeatherService(handler)
    }
}

protocol WeatherService {
    func fetchWeatherForCity(_ cityId: String?, completion: @escaping WeatherCompletionBlock)
}
extension WeatherService {
    func fetchWeatherForCity(_ cityId: String?, completion: @escaping WeatherCompletionBlock) {
        if let service = self as? LiveWeatherService {
            guard let cityId =  cityId else { return }
            service.fetchWeatherForCity(cityId, completion: completion)
        }else if let service = self as? OfflineWeatherService {
            service.fetchWeather(completion)
        }
    }
}


