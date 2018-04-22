//
//  EndPoinst.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import Alamofire

enum EndPoins {
    case getWeather(city: City, countyCode: Country, batchCount: Int)
    
    var url: String {
        switch self {
        case .getWeather(_, _, _): return ApiConstans.ApiPaths.getWeather
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    var parametres: [String: Any] {
        switch self {
        case .getWeather(let city, let countyCode, let batchCount):
            return self.weatherParametres(city: city.rawValue, countyCode: countyCode.code, batchCount: batchCount)
        }
    }
        
    var encoding: Alamofire.ParameterEncoding {
        switch self {
        default: return Alamofire.URLEncoding.default
        }
    }
}

fileprivate extension EndPoins {
    func weatherParametres(city: String, countyCode: String, batchCount: Int) -> [String: Any] {
        return [
            QueryKeys.location: [city, countyCode].joined(separator: ","),
            QueryKeys.couns: batchCount,
            QueryKeys.apiKey: Constans.WeatherApi.apiKey
        ]
    }
}
