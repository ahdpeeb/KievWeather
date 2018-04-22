//
//  Date + Extension.swift
//  DigitalBank
//
//  Created by Nikola Andriiev on 3/20/17.
//  Copyright © 2017 iosDeveloper. All rights reserved.
//

import Foundation

extension Date {
    public func stringWith(format: String) -> String {
        let dateformatter = DateFormatter()
        dateformatter.amSymbol = "am";
        dateformatter.pmSymbol = "pm";
        dateformatter.dateFormat = format
        return dateformatter.string(from: self)
    }
}
