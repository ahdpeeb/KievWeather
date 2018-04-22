//
//  Weather.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import ObjectMapper

final class Weather: Model<RLMWeather>, Mappable {
    
    public var data: Int? { didSet { self.write() } }
    public var main: String? { didSet { self.write() } }
    public var info: String? { didSet { self.write() } }
    public var icon: String? { didSet { self.write() } }
    public var tempDay: Int? { didSet { self.write() } }
    public var tempMin: Int? { didSet { self.write() } }
    public var tempMax: Int? { didSet { self.write() } }
    public var tempNight: Int? { didSet { self.write() } }
    public var tempEve: Int? { didSet { self.write() } }
    public var tempMorn: Int? { didSet { self.write() } }
    
    //Probleb: server returns 16 weather objects for city, all objects have 4 differt ID 500, 501, 800, 803 (so i have to replace primary key with date)
    
    // fatalError for debag mode
    /* guard let weather = map.JSON["weather"] as? [[String: Any]] else { fatalError("weather reqest parsing error") }
    guard let id = weather.first?["id"] as? Int else { fatalError("weather reqest parsing error") } */
    
    required init?(map: Map) {
        guard let id = map.JSON["dt"] as? Int else { return nil }
        super.init(id: ID(integerLiteral: id))
    }
    
    public required init(id: ID) {
        super.init(id: id)
    }
    
    func mapping(map: Map) {
        self.data <- map["dt"]
        self.main <- map["weather.[0].main"]
        self.info <- map["weather.[0].description"]
        self.icon <- map["weather.[0].icon"]
        self.tempDay <- map["temp.day"]
        self.tempMin <- map["temp.min"]
        self.tempMax <- map["temp.max"]
        self.tempNight <- map["temp.night"]
        self.tempEve <- map["temp.eve"]
        self.tempMorn <- map["temp.morn"]
    }
    
    //MARK: Requered override
    
    open override func wtiteStorage(_ storage: StorageType) {
        storage.data.value = self.data
        storage.main = self.main
        storage.info = self.info
        storage.icon = self.icon
        storage.tempDay.value = self.tempDay
        storage.tempMin.value = self.tempMin
        storage.tempMax.value = self.tempMax
        storage.tempNight.value = self.tempNight
        storage.tempEve.value = self.tempEve
        storage.tempMorn.value = self.tempMorn
    }
    
    open override func readStorage(_ storage: StorageType) {
        self.data = storage.data.value
        self.main = storage.main
        self.info = storage.info
        self.icon = storage.icon
        self.tempDay = storage.tempDay.value
        self.tempMin = storage.tempMin.value
        self.tempMax = storage.tempMax.value
        self.tempNight = storage.tempNight.value
        self.tempEve = storage.tempEve.value
        self.tempMorn = storage.tempMorn.value
    }
}
