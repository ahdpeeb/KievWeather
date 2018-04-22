//
//  LocalStoreManager+Api.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/22/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation

extension LocalStorageManager {
    public func city(id: String) -> City? {
        guard let rlmCity = self.loadObject(type: RLMCity.self, id: id) else { return nil }
        return City.instantiate(storage: rlmCity)
    }
    
    public func allWeather() -> [Weather] {
        guard let allRLMWeather = self.loadObjects(type: RLMWeather.self) else { return [] }
        let allWEather = allRLMWeather.compactMap({ rlmWeather in
            return Weather.instantiate(storage: rlmWeather)
        })
        
        return allWEather
    }
    
    public func allCities() -> [City] {
        guard let allRLMCities = self.loadObjects(type: RLMCity.self) else { return [] }
        let allCityes = allRLMCities.compactMap({ City.instantiate(storage: $0) })
        return allCityes
    }
}
