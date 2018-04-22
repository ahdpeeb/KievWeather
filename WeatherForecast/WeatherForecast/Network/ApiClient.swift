//
//  ApiClient.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import Alamofire

typealias WeatherCompletion = (_ weather: [Weather]) -> Void

class ApiClient: AbstractApiClient {
    static var shared = ApiClient()
    
    
}

extension ApiClient {
    func loadKievWeather(batchCount: Int = 16, onCompletion: WeatherCompletion?, onError: ErrorClosure?) {
        let api = EndPoins.getWeather(city: .Kiev, countyCode: .Ukraine, batchCount: batchCount)
        self.loadObjects(url: api.url, method: api.method, options: api.parametres, encoding: api.encoding, headers: nil, onResult: onCompletion, onError: onError)
    }
}
