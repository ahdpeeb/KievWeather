//
//  RLMWeather.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import RealmSwift

class RLMWeather: RLMModel {
    let date = RealmOptional<Int>()
    @objc dynamic var main: String?
    @objc dynamic var info: String?
    @objc dynamic var icon: String?
    let tempDay = RealmOptional<Double>()
    let tempMin = RealmOptional<Double>()
    let tempMax = RealmOptional<Double>()
    let tempNight = RealmOptional<Double>()
    let tempEve = RealmOptional<Double>()
    let tempMorn = RealmOptional<Double>()
}
