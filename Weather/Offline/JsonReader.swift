//
//  JsonReader.swift
//  Weather
//
//  Created by Arslan Faisal on 30/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

/// Provides default implementation of method *dataFromJsonFile*
/// Reads  json file bundled with app in main bundle and provides *Data* object for json.
protocol JsonReader {
    /// Reads json file bundled with app in main bundle and provides *Data* object for json.
    /// Returns *Data* object after reading json file, nil in case file is not found or fails to convert to *Data*. Throws error if fails to read file
    /// - Parameter name: file name  to be read
    @discardableResult
    func dataFromJsonFile(_ name: String) throws -> Data?
}
extension JsonReader {
    /// Reads json file bundled with app in main bundle and provides *Data* object for json.
    /// Returns *Data* object after reading json file, nil in case file is not found or fails to convert to *Data*. Throws error if fails to read file
    /// - Parameter name: file name  to be read
    @discardableResult
    func dataFromJsonFile(_ name: String) throws -> Data? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else { return nil}
        do {
            let response: String = try String(contentsOf: url)
            guard let data = response.data(using: .utf8, allowLossyConversion: false) else { return nil }
            return data
        } catch(let error) {
            throw error
        }
    }
}
