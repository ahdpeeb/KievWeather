//
//  WeatherRegins.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation

enum CityType: String {
    case Kiev
}

enum CountryType {
    case Ukraine
    
    var code: String {
        switch self {
        case .Ukraine: return "ua"
        }
    }
}
