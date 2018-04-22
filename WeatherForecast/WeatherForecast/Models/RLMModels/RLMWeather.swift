//
//  RLMWeather.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import RealmSwift

class RLMWeather: RMLModel {
    let data = RealmOptional<Int>()
    @objc dynamic var main: String?
    @objc dynamic var info: String?
    @objc dynamic var icon: String?
    let tempDay = RealmOptional<Int>()
    let tempMin = RealmOptional<Int>()
    let tempMax = RealmOptional<Int>()
    let tempNight = RealmOptional<Int>()
    let tempEve = RealmOptional<Int>()
    let tempMorn = RealmOptional<Int>()
}
