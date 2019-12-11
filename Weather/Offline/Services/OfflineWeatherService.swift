//
//  cityService.swift
//  Weather
//
//  Created by Arslan Faisal on 30/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

/// Reads bundled weather API result json file
struct OfflineWeatherService: WeatherService, JsonReader, DataModelDecoder {
    
    /// Reads bundled weather API result json file and decods into decodable *ForcastResult* model
    /// - Parameter completion: Completion closure with  *ForcastResult*  objects or error string
    func fetchWeather(_ completion: @escaping WeatherCompletionBlock) {
        do {
            let jsonData = try dataFromJsonFile("lahore")
            guard let data = jsonData else {
                completion(nil,NetworkResponse.badRequest.rawValue)
                return
            }
            let forcastResultModel : ForcastResult? = try self.decodeModel(data: data)
            guard var forcastResult = forcastResultModel else {
                completion(nil, NetworkResponse.noData.rawValue)
                return
            }
            forcastResult.list = convertToCelciusIfRequired(forcastResult.list)
            completion(forcastResult, nil)
        } catch (let error){
            completion(nil, error.localizedDescription)
        }
    }
    func convertToCelciusIfRequired(_ forcasts: [Forcast?]?) -> [Forcast?]? {
        let locale = NSLocale.current as NSLocale
        guard let unitStr = locale.object(forKey: NSLocale.Key(rawValue: NotificationNames.kCFLocaleTemperatureUnitKey)) as? String, unitStr.lowercased() == "celsius" else { return forcasts }
        let celciusForcasts = forcasts?.map({ forcast -> Forcast? in
            var updatedForcast = forcast
            let celciusTemp = Utility.changeFarenheitToCelcius(forcast?.weatherParticular?.temp)
            updatedForcast?.weatherParticular?.updateTemp(celciusTemp)
            return updatedForcast
        })
        return celciusForcasts
    }
}
