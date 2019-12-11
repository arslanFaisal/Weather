//
//  AutoCompleteViewModel.swift
//  Weather
//
//  Created by Arslan Faisal on 29/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
class AutoCompleteViewModel {
    let offlineCityService = OfflineCityService()
    var allCities = [City?]()
    
    lazy var cities: Bindable<[City?]> = Bindable([City?]())
    lazy var cityToSearch: Bindable<City?> = Bindable(nil)
    var searchLister: Bindable<String>.Listener?
    
    init() {
        searchLister = { [weak self] searchTerm in
            self?.fetchPredictions(searchTerm)
        }
        DispatchQueue.global().async { [weak self] in
            self?.fetchCities()
        }
    }
}
//MARK:- Data Fetching and Handling
extension AutoCompleteViewModel {
    
    /// Fetches all the cities from offline cities.json file
    func fetchCities() {
        offlineCityService.fetchCities { [weak self] (cities, error) in
            if error == nil, let citiesList = cities {
                self?.allCities = citiesList
                
            }
        }
    }
    
    /// sets *cities* array to top 50 search results from allCities array for the searched term, if searched term is shorter than *minimumSearchTermCharacters* characters no search is done and its ignored.
    /// - Parameter searchTerm: user's searched term
    func fetchPredictions(_ searchTerm: String) {
        guard searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).count > SearchTerm.minimumSearchTermCharacters else { return }
        let searchText = searchTerm.lowercased()
        let searchResults = allCities.filter { ($0?.name?.lowercased().contains(searchText) ?? false) }.prefix(50)
        cities.value = Array(searchResults)
    }
}
//MARK:- View Helpers
extension AutoCompleteViewModel {
    func numberOfRows() -> Int {
        return cities.value.count
    }
    func cityAtIndex(_ index: Int) -> City? {
        return cities.value[index]
    }
    func predictionText(_ index: Int) -> String {
        guard let city = cityAtIndex(index), let cityName = city.name, let country = city.country else { return "" }
        return cityName + "," + country
    }
}
