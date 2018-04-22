//
//  City.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/22/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

final class City: Model<RLMCity>, Mappable {
    public var name: String? { didSet { self.write() } }
    public var country: String? { didSet { self.write() } }
    public var weather: [Weather]? { didSet { self.write() } }
    
    func mapping(map: Map) {
        self.name <- map["city.name"]
        self.country <- map["city.country"]
        self.weather <- map["list"]
    }
    
    required init?(map: Map) {
        guard let weather = map.JSON["city"] as? [String: Any], let id = weather["id"] as? Int else { return nil }
        super.init(id: ID(integerLiteral: id))
    }
    
    public required init(id: ID) {
        super.init(id: id)
    }
    
    //MARK: Requered override
    open override func wtiteStorage(_ storage: StorageType) {
        storage.name = self.name
        storage.country = self.country
        
        let rlmWeathers = (self.weather ?? []).map({ $0.storage })
        //should remove all old weather for this city
        storage.weather.removeAll()
        storage.weather.append(objectsIn: rlmWeathers)
    }
    
    open override func readStorage(_ storage: StorageType) {
        self.name = storage.name
        self.country = storage.country
        
        let weathers: [Weather] = storage.weather.compactMap({ rlmWeather in
            return Weather.instantiate(storage: rlmWeather)
        })
        
        self.weather = weathers
    }
}
