//
//  RLMCity.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/22/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation
import RealmSwift

class RLMCity: RLMModel {
    @objc dynamic var name: String?
    @objc dynamic var country: String?
    var arrayOfSchedule = List<RLMWeather>()
}
