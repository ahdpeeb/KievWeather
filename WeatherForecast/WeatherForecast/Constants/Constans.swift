//
//  Constans.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation

typealias SimpleClosure = () -> Void
typealias ErrorClosure = (_ error: Error) -> Void
typealias AnyDict = [String: Any]
typealias StringDict = [String: String]

struct Constans {    
    enum WeatherApi: String {
        case apiKey = "bd5e378503939ddaee76f12ad7a97608"
    }
    
    struct ErrorMessage {
        static let JSONdeserelization = "Can't serealize server responce to json"
        static let JSONCollectionDeserelization = "Can't serealize server responce to json collection"
        static let internetConnection = "No internet connection"
    }
}
