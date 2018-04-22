//
//  Atomic.swift
//  СonsistencyMinder
//
//  Created by Nikola Andriiev on 2/25/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

public class Atomic<Value> {
    
    //MARK: Subtipe
    
    public typealias ValueType = Value
    public typealias PropertyObserver = ((old: Value, new: Value)) -> Void
    
    //MAKR: Properties
    
    public var value: Value {
        get { return self.transform({ $0 }) }
        set { self.modify({ $0 = newValue }) }
    }
    
    private var mutableValue: ValueType
    
    private var lock: NSLocking = NSRecursiveLock()
    private var didSet: PropertyObserver?
    
    //MAKR: Init
    
    public init(_ value: ValueType,
                lock: NSLocking = NSRecursiveLock(),
                didSet: PropertyObserver? = nil)
    {
        self.mutableValue = value
        self.lock = lock
        self.didSet = didSet
    }
    
    //MARK: Public
    
    //Writing
    @discardableResult
    public func modify<Result>(_ action: (inout ValueType) -> Result) -> Result {
        self.lock.lock()
        let oldValue = self.mutableValue
        
        defer {
            self.didSet?((oldValue, self.mutableValue))
            self.lock.unlock()
        }
        
        return action(&self.mutableValue)
    }
    
    //Reading
    public func transform<Result>(_ action: (ValueType) -> Result) -> Result {
        self.lock.lock()
        defer { self.lock.unlock() }
        return action(self.mutableValue)
    }
}
