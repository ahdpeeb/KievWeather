//
//  WeakBox.swift
//  СonsistencyMinder
//
//  Created by Nikola Andriiev on 2/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

public struct WeakBox<Wrapped: AnyObject> {
    public private(set) weak var wrapped: Wrapped?
    
    public var isEmpty: Bool {
        return self.wrapped == nil
    }
    
    public init(_ wrapped: Wrapped?) {
        self.wrapped = wrapped
    }
}

extension WeakBox: Equatable {
    public static func ==(lhs: WeakBox, rhs: WeakBox) -> Bool {
        return lhs.wrapped.flatMap({ lhs in
            rhs.wrapped.map({ $0 === lhs })
        }) ?? false
    }
}
