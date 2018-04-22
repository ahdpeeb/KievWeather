//
//  RLMUser.swift
//  СonsistencyMinder
//
//  Created by Nikola Andriiev on 2/25/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class RLMUser: RLMModel {
    @objc dynamic var name: String?
    let age = RealmOptional<Int>()
}
