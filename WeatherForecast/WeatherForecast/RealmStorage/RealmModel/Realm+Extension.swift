//
//  Realm+Extension.swift
//  СonsistencyMinder
//
//  Created by Nikola Andriiev on 2/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import RealmSwift

public extension Realm {
    
    //MARK: Sybtypes
    
    private struct Key {
        static let realm = "com.realm.thread.key"
    }
    
    // if current Real exist in current thread return current Real, otherwise create new
    public static var current: Realm? {
        let key = Key.realm
        let thread = Thread.current
        
        return thread.threadDictionary[key]
            .flatMap{ $0 as? WeakBox<Realm> }
            .flatMap{ $0.wrapped }
            ?? call {
                (try? Realm()).map(
                    sideEffect { thread.threadDictionary[key] = WeakBox($0) }
                )
            }
    }
    
    public static func write(action: (Realm) -> Void) {
        self.current.do { realm in
            if realm.isInWriteTransaction {
                action(realm)
            } else {
                try? realm.write {
                    action(realm)
                }
            }
        }
    }
}
