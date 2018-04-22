//
//  RMLModel.swift
//  СonsistencyMinder
//
//  Created by Nikola Andriiev on 2/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

import RealmSwift

public class RLMModel: Object {
    @objc dynamic var id: String = ""
    
    //MARK: Override
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
}
