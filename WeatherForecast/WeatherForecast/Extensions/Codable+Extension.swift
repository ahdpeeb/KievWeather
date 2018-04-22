//
//  Codable+Extension.swift
//  СonsistencyMinder
//
//  Created by Nikola Andriiev on 2/22/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

extension Encodable {
    func toJson() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
    }
}

extension Dictionary {
    func toModel<T: Decodable>(_ type: T.Type) -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: self,
                                                            options: .prettyPrinted)
            else { return nil }
        
        return try? JSONDecoder().decode(type.self, from: data)
    }
}
