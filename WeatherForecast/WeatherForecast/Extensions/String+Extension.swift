//
//  String + extension.swift
//  CityTradesman
//
//  Created by Nikola Andriiev on 3/3/17.
//  Copyright © 2017 iosDeveloper. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func nullifyIfEmpty() -> String? {
        return self.isEmpty ? nil : self
    }
    
    func isBlank() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return trimmed.isEmpty
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func toError() -> NSError {
        return NSError(domain: String(),
                       code: 0,
                       userInfo: [NSLocalizedDescriptionKey : self])
    }
}
