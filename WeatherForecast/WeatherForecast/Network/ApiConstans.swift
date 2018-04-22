//
//  ApiConstans.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation

struct ApiConstans {
    struct ApiPaths {
        static let getWeather = "http://api.openweathermap.org/data/2.5/forecast/daily"
    }
}

struct QueryKeys {
    static let location = "q" // city, country code, separated by coma
    static let couns = "cnt" // number of days
    static let apiKey = "APPID"
    static let units = "units"
}
