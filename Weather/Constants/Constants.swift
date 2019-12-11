//
//  Constants.swift
//  Weather
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

/// Holds constants for Open Weather API
enum WeatherAPIKey {
    static let key = "1241348d6b5e40a746e89639f3e1b32c"
    static let defaultCity = City(id: 1172451, name: "Lahore", country: "PK")
}
/// Holds constants for Constraint values
enum SearchTerm {
    static let minimumSearchTermCharacters = 2
}
/// Holds constants for Notification names
enum NotificationNames {
    static let networkReachability = "networkReachability"
    static let kCFLocaleTemperatureUnitKey = "kCFLocaleTemperatureUnitKey"
}
/// Holds constants for Segue names
enum Segues {
    static let autoCompleteSegue = "autoCompleteSegue"
}
/// Holds constants for Constraint values
enum Constraints {
    static let textFieldHeight = CGFloat(44.0)
}
/// Holds constants for view title values
enum Titles {
    static let offlineTitle = "Offline Lahore,PK"
    static let liveTitle = "Live Forcast"
}
/// Holds constants for Cell identifiers
enum CellIdentifiers {
    static let weatherCellIdentifier = "weatherCellIdentifier"
    static let weatherDateHeaderIdentifier = "weatherDateHeaderIdentifier"
    static let autoCompleteCellIdentifier = "autoCompleteCellIdentifier"
}
/// Holds constants for Collection flow layout values
enum WeatherCollectionFlowLayOut {
    enum WeatherCollectionItem {
        static let itemLeadingSpace: CGFloat  = 5.0
        static let itemTrailingSpace: CGFloat = 0.0
        static let itemTopSpace: CGFloat = 0.0
        static let itemBottomSpace: CGFloat = 0.0
        static let itemWidth: CGFloat = 145.0
        static let itemHeight: CGFloat = 160.0
    }
    enum WeatherCollectionSection {
        static let sectionLeadingSpace: CGFloat  = 0.0
        static let sectionTrailingSpace: CGFloat = 0.0
        static let sectionTopSpace: CGFloat = 5.0
        static let sectionBottomSpace: CGFloat = 5.0
        static let sectionHeaderHeight: CGFloat = 44.0
    }
    
}
