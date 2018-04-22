//
//  Functions.swift
//  СonsistencyMinder
//
//  Created by Nikola Andriiev on 2/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

func call<Value>(_ action: () -> Value) -> Value {
    return action()
}

func sideEffect<Value>(action: @escaping (Value) -> Void) -> (Value) -> Value {
    return {
        action($0)
        
        return $0
    }
}

// modify value, return mutated value 
func modify<Value>(_ value: Value, action: (inout Value) -> Void) -> Value {
    var result = value
    action(&result)
    
    return result
}

func lift<A, B>(_ value: (A?, B?)) -> (A, B)? {
    return value.0.flatMap { lhs in
        value.1.flatMap { (lhs, $0) }
    }
}

func executeBackground<T>(_ block: @escaping () -> (T?), notifyMain completion: @escaping ((_: T?) -> ())) {
    DispatchQueue.global(qos: .background).async {
        let result: T? = block()
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

func delay(seconds: Double, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}
