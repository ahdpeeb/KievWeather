//
//  Model.swift
//  СonsistencyMinder
//
//  Created by Nikola Andriiev on 2/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import RealmSwift

public class Model<Storage: RMLModel> {
    
    //MARK: Sybtypes
    
    public typealias StorageType = Storage
    
    //MARK: Static
    
    public static func instantiate(storage: StorageType?) -> Self? {
        return storage
            .flatMap({ $0.id.split(separator: "_").first })
            .flatMap({ ID(string: String($0)) })
            .map(self.init)
    }
    
    //MARK: Properties
    
    public var id: ID
    
    public var storageID: String {
        return "\(self.id)_\(String(describing: type(of: self)).lowercased())"
    }
    
    //if object exist -> return it, otherwise created new, assign ID, return new object
    public var storage: StorageType {
        let id = self.storageID
        return Realm.current?.object(ofType: StorageType.self, forPrimaryKey: id)
            ?? modify(StorageType()) { storage in
                storage.id = id
                Realm.write { $0.add(storage, update: true) }
            }
    }
    
    private let lock: NSLocking = NSRecursiveLock()
    private var isInWriteTransaction = false
    private var isInReadTransaction = false
    
    //MARK: Init and Deinit
    
    public required init(id: ID) {
        self.id = id
        
        self.configure()
    }
    
    public convenience init(_ id: Int) {
        self.init(id: ID(id))
    }
    
    //MARK: Public
    
    public func read() {
        self.performStorageTransaction(
            excluding: { self.isInWriteTransaction },
            condition: { self.isInReadTransaction = $0 },
            action: { self.readStorage(self.storage) }
        )
    }
    
    public func write() {
        self.update {
            self.wtiteStorage(self.storage)
        }
    }
    
    public func update(action: () -> ()) {
        self.performStorageTransaction(
            excluding: { self.isInReadTransaction },
            condition: { self.isInWriteTransaction = $0 },
            action: {
                Realm.write { _ in
                    action()
                }
            }
        )
    }
    
    //MARK: Open
    
    open func configure() {
        self.read()
    }
    
    //Should be overridden in child classes
    
    open func wtiteStorage(_ storage: StorageType) {
        
    }
    
    open func readStorage(_ storage: StorageType) {
        
    }
    
    //MARK: Private
    
    private func locked(action: () -> ()) {
        self.lock.lock()
            action()
        self.lock.unlock()
    }
    
    private func performStorageTransaction(
        excluding: () -> Bool,
        condition: (Bool) -> Void,
        action: () -> ())
    {
        self.locked {
            if excluding() {
                return
            }
            
            condition(true)
            action()
            condition(false)
        }
    }
}
