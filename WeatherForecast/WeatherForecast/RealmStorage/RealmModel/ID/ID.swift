//
//  ID.swift
//  СonsistencyMinder
//
//  Created by Nikola Andriiev on 2/25/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

public struct ID {
    
    //MARK: Properties
    public let value: Int
    
    public init(_ value: Int) {
        self.value = value
    }
    
    public init?(string: String) {
        guard let value = Int(string) else { return nil }
        self.init(value)
    }
}

extension ID: Comparable {
    public static func <(lhs: ID, rhs: ID) -> Bool {
        return lhs.value < rhs.value
    }
}

extension ID: Equatable {
    public static func ==(lhs: ID, rhs: ID) -> Bool {
         return lhs.value == rhs.value
    }
}

extension ID: Hashable {
    public var hashValue: Int {
        return self.value.hashValue
    }
}

extension ID: CustomStringConvertible {
    public var description: String {
        return self.value.description
    }
}

extension ID: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(value)
    }
}
