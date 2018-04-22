//
//  User.swift
//  СonsistencyMinder
//
//  Created by Nikola Andriiev on 2/25/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class User: Model<RLMUser> {
    
    public var name: String? {
        didSet { self.write() }
    }
    
    public var age: Int? {
        didSet { self.write() }
    }
    
    //MARK: Open
    
    open override func wtiteStorage(_ storage: StorageType) {
        storage.name = self.name
        storage.age.value = self.age
    }
    
    open override func readStorage(_ storage: StorageType) {
        self.name = storage.name
        self.age = storage.age.value
    }
}

