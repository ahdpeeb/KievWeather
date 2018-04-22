//
//  DataManager.swift
//  WeatherForecast
//
//  Created by Nikola Andriiev on 4/22/18.
//  Copyright © 2018 Nikola Andriiev. All rights reserved.
//

import Foundation

//MARK: User defaults
enum Settings: String {
    case lastLoadedCityID
}

final class DataManager {
    static let shared = DataManager()
    
    func saveObject<T: NSCoding>(object: T?, key: String) {
        if let object = object {
            let object = NSKeyedArchiver.archivedData(withRootObject: object)
            UserDefaults.standard.set(object, forKey: key)
        }
    }
    
    func object<T: NSCoding>(key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? T
        }
        
        return nil
    }
}

//MARK: Load data
extension DataManager {
    var lastLoadedCityID: String? {
        set { UserDefaults.standard.set(newValue, forKey: Settings.lastLoadedCityID.rawValue) }
        get { return UserDefaults.standard.value(forKey: Settings.lastLoadedCityID.rawValue) as? String }
    }
}
