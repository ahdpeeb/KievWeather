//
//  Double+Extension.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/23/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
