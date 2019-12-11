//
//  ModelDecoder.swift
//  Weather
//
//  Created by Arslan Faisal on 30/11/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

/// Data to Model decoder protocol, provides default implementation of method *decodeModel*
protocol DataModelDecoder {}

extension DataModelDecoder {
    
    /// Data to specified Model decoder, Model must confirm the *Decodable*  protocol
    /// throws error if failed to decode model
    /// Returns specified  model or nil in case input *data* parameter is nil or decoding fails
    /// - Parameter data: *Data* object to be  decoded
    func decodeModel<DataModel: Decodable>(data: Data?) throws -> DataModel? {
        guard let data = data else {
            return nil
        }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)

        do {
            let model = try jsonDecoder.decode(DataModel.self, from: data)
            return model
        } catch (let decodeError) {
            throw decodeError
        }
    }
}
