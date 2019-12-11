//
//  WeatherCollectionCellViewModel.swift
//  Weather
//
//  Created by Arslan Faisal on 29/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
import UIKit

class WeatherCollectionCellViewModel {
    
    private let imageService = ImageService(NetworkHandler())
    private(set) var weatherIconImg: Bindable<UIImage?> = Bindable(nil)
    var forcast: Forcast?
    
    /// Returns temprature value rounded to two decimal places for forcast in form of string, or empty string if forcast date is nil
    var forcastTemprature: String {
        guard let temprature = forcast?.weatherParticular?.temp else { return "" }
        return temprature.format(f: "0.2") + " " + Utility.getUserTempUnitSymbol()
    }
    
    /// Returns time value for forcast in form of string, or empty string if forcast date is nil
    var forcastTime: String {
        guard let date = forcast?.date else { return "" }
        return date.timeStringWithoutDate()
    }
    
    /// Internal function that can be called by other classes to fetch weather Icon for *forcast* object
    func fetchIcon() {
        fetchIcon(forcast)
    }
    
    /// Fetches weather icon for the forcast and on receiving result  makes sure that icon is only set if the cell is still showing the forcast for which call was sent. If the cell is dequeued and ViewModel has another focast icon is ignored
    /// - Parameter forcastToFetch: forcast object to fetch icon for, its passed to function so it could be reatined in functions's scope and compared with the view model forcast object when call back is received.
    private func fetchIcon(_ forcastToFetch: Forcast?) {
        guard let weather = forcastToFetch?.weather?.first, let imagePath = weather?.icon else { return }
        imageService.fetchImage(imagePath) { [weak self] (image, error) in
            if let _ = error { return }
            guard let image = image else { return }
            if let forcastModel = self?.forcast, let weather = forcastModel.weather?.first, let weatherToFetch = forcastToFetch?.weather?.first, weather?.icon == weatherToFetch?.icon {
                self?.weatherIconImg.value = image
            }
        }
    }
}
