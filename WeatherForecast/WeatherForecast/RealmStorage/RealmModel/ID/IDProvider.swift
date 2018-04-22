//
//  IDAutoincrementProvider.swift
//  СonsistencyMinder
//
//  Created by Nikola Andriiev on 2/25/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

public typealias IDProvider = () -> ID

//ID Provider for different entities
public func autoIncrementedGenerator(start: Int) -> IDProvider {
    let value = Atomic(start)
    
    return {
        value.modify {
            let result = $0
            $0 += 1
            
            return ID(result)
        }
    }
}

fileprivate let persistentProviders = Atomic([String: IDProvider]())

public func autoIncrementedID(key: String) -> IDProvider? {
    let defaults = UserDefaults.standard
    
    return persistentProviders.modify { storage in
        let result = storage[key] ?? call {
            let value = Atomic(defaults.integer(forKey: key))
            
            return {
                value.modify({
                    let result = $0
                    $0 += 1
                    defaults.setValue($0, forKey: key)
                    
                    return ID(result)
                })
       
            }
        }
        
        storage[key] = result
        
        return result
    }
}
