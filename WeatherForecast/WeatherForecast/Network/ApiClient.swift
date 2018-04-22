//
//  ApiClient.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import Alamofire

typealias CityWeatherCompletion = (_ city: City?) -> Void

class ApiClient: AbstractApiClient {
    static var shared = ApiClient()
}

extension ApiClient {
    func loadKievWeather(batchCount: Int = 16, onCompletion: CityWeatherCompletion?, onError: ErrorClosure?) {
        let api = EndPoins.getWeather(city: .Kiev, countyCode: .Ukraine, batchCount: batchCount)
        self.loadObject(url: api.url, method: api.method, options: api.parametres, encoding: api.encoding, onResult: onCompletion, onError: onError)
    }
}
