//
//  Optinal+Extension.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/21/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation

extension Optional {
    func `do`(_ execute: (Wrapped) -> ()) {
        self.map(execute)
    }
}
