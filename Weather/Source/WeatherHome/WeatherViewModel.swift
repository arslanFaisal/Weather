//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Arslan Faisal on 28/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
/// Data Model with forcasts for a date
struct WeatherDateMap {
    let date: Date
    let forcasts: [Forcast?]
}
/// type of date being displayed in view offline or live
enum ViewType {
    case live
    case offline
}
class WeatherViewModel {
    var weatherService = WeatherServiceFactory.weatherService(NetworkHandler())
    
    lazy var dataFetchErrorString: Bindable<String?> = Bindable(nil)
    lazy var dateWiseForcastArray: Bindable<[WeatherDateMap]> = Bindable([WeatherDateMap]())
    lazy var citySearchTerm: Bindable<String> = Bindable("")
    lazy var viewType: Bindable<ViewType> = Bindable(ViewType.live)
    var lastLiveForcastResult: ForcastResult?
    var lastLiveForcast: [WeatherDateMap]?
    
    var autoSelectionLister: Bindable<City?>.Listener?
    var hideAutoCompleteView: (()->())?

    init() {
        let _ = NetworkReachability.shared
        autoSelectionLister = { [weak self] cityToSearch in
            self?.hideAutoCompleteView?()
            self?.fetchWeatherForCity(cityToSearch)
        }

        /// Shows either offline weather  or previously fetched live weather on  viewType changes by user
        viewType.bind({ [weak self] type in
            self?.resetWeatherService()
            switch type {
            case .offline:
                self?.fetchWeatherForCity(nil)
            default:
                self?.loadLastLiveForcast()
            }
        })
    }
    deinit {
        removeObserver()
    }
}
//MARK:- Data Fetching and Handling
extension WeatherViewModel {
    
    /// Sets weatherService object to live or offline weather service depending upon view type
    func resetWeatherService() {
        let networkHandler: NetworkHandler? = viewType.value == .offline ? nil : NetworkHandler()
        weatherService = WeatherServiceFactory.weatherService(networkHandler)
    }
    
    /// Fetch weather  for specific city selected  by user or ncity is  nil in case of offline city search
    /// - Parameter city: city selected by user via autocomplete
    func fetchWeatherForCity(_ city: City?) {
        var cityID: String? = nil
        if let cityId = city?.id {
            cityID = String(cityId)
        }
        weatherService.fetchWeatherForCity(cityID) { [weak self]  (forcastResult, error) in
            self?.handlerForcastResponse(forcastResult, error: error)
        }
    }
    
    /// Handles Forcast Service completion block
    /// - Parameters:
    ///   - forcastResult: ForcastResult  from weather service
    ///   - error: error srting from weather service
    func handlerForcastResponse(_ forcastResult: ForcastResult?, error: String?) {
        if let error = error {
            dataFetchErrorString.value = error
        }else if let forcasts = forcastResult?.list {
            updateLastLiveForcastResultIfRequired(forcastResult)
            forcastMapper(forcasts)
        }
    }
    
    /// Converts Forcast data into a date wise mapping, each forcast is placed under its own day so that a specific day's data can be shown
    /// Final array is sorted on date so that most recent date is at top
    /// - Parameter forcasts: array of *Forcast* objects
    func forcastMapper(_ forcasts: [Forcast?]) {
        let forcastDict = forcasts.reduce([Date: [Forcast?]]()) { (dict, forcast) -> [Date: [Forcast?]] in
            var dict = dict
            let forcastDateStr = forcast?.date?.dateStringWithoutTime()
            let date = forcastDateStr?.dateFromString()
            if let date = date, var dateForcasts = dict[date] {
                dateForcasts.append(forcast)
                dict[date] = dateForcasts
            }else if let date = date {
                dict[date] = [forcast]
            }
            return dict
        }
        var dateWiseForcasts = forcastDict.map { (key,value) -> WeatherDateMap in
            return WeatherDateMap(date: key, forcasts: value)
        }
        dateWiseForcasts = dateWiseForcasts.sorted(by: { return $0.date < $1.date })
        updateLastLiveForcastIfRequired(dateWiseForcasts)
        dateWiseForcastArray.value = dateWiseForcasts
    }
    
    /// Saves live weather ForcastResult into *lastLiveForcastResult* if user fetched live data
    /// - Parameter forcastResult: Feteched forcast result
    func updateLastLiveForcastResultIfRequired(_ forcastResult: ForcastResult?) {
        if viewType.value == .live {
            lastLiveForcastResult = forcastResult
        }
    }
    
    /// Saves live weather *WeatherDateMap* array into *lastLiveForcast* if user fetched live data
    /// - Parameter forcast: *WeatherDateMap* array
    func updateLastLiveForcastIfRequired(_ forcast: [WeatherDateMap]) {
        if viewType.value == .live {
            lastLiveForcast = forcast
        }
    }
    
    /// shows last live fetched forcast if available
    func loadLastLiveForcast() {
        guard let dateWiseForcast = lastLiveForcast else { return }
        dateWiseForcastArray.value = dateWiseForcast
    }
}
//MARK:- View Helpers
extension WeatherViewModel {
    func numberOfSections() -> Int {
        return dateWiseForcastArray.value.count
    }
    func numberOfItemsInSection(_ section: Int) -> Int {
        return dateWiseForcastArray.value[section].forcasts.count
    }
    func forcastAtSection(_ section: Int, row: Int) -> Forcast? {
        return dateWiseForcastArray.value[section].forcasts[row]
    }
    func dateStringForSection(_ section: Int) -> String {
        return dateWiseForcastArray.value[section].date.dateStringWithoutTime()
    }
    func titleForView() -> String {
        var viewTitle = viewType.value == .live ? Titles.liveTitle : Titles.offlineTitle
        guard let forcastResult = lastLiveForcastResult, let cityName = forcastResult.city?.name, let countryName = forcastResult.city?.country, viewType.value == .live else { return viewTitle }
        viewTitle = cityName + "," + countryName
        return viewTitle
    }
}
//MARK:- Reachability
extension WeatherViewModel {
    func addConnectivityObserver() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.connectivityChanged(notification:)), name: NSNotification.Name(rawValue: NotificationNames.networkReachability), object: nil)
    }
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func connectivityChanged(notification: Notification) {
        guard let connectivity = notification.object as? Bool else { return }
        if connectivity {
        }
    }
}
