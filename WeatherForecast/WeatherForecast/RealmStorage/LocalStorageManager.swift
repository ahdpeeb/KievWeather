//
//  LocalStorageManager.swift
//  СonsistencyMinder
//
//  Created by Admin on 7/4/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class LocalStorageManager {
    static var shared = LocalStorageManager()
    
    func loadObjects<T: Object>(type: T.Type) -> [T]? {
        let realm = try! Realm()
        return Array(realm.objects(type.self))
    }
    
    func loadObject<T: Object>(type: T.Type, id: String) -> T? {
        guard let realm = try? Realm() else { return nil }
        return realm.object(ofType: type.self, forPrimaryKey: id)
    }
    
    func loadObject<T: Object>(type: T.Type, predicate: NSPredicate?) -> T? {
        guard let realm = try? Realm() else { return nil }
        if let predicate = predicate {
            return realm.objects(type.self).filter(predicate).first
        } else {
            return realm.objects(type.self).first
        }
    }
    
    func save<T: Object>(object: T) {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            realm.add(object)
        }
    }
    
    func delete(model: Object?) {
        guard let realm = try? Realm(), let model = model else { return }
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func write(_ block: () -> ()) {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            block()
        }
    }
}
