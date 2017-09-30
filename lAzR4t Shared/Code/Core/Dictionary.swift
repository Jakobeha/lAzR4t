//
//  Dictionary.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

extension Dictionary {
    init(keys: [Key], valueGetter: (Key) throws -> Value) rethrows {
        self.init(uniqueKeysWithValues: try keys.map { key in
            return (key, try valueGetter(key))
        })
    }
    
    func flatMapValues<Value2>(_ transform: (Value) throws -> Value2?) rethrows -> [Key:Value2] {
        return try flatMapDict { entry in
            return try transform(entry.value).map { newValue in (entry.key, newValue) }
        }
    }
    
    func flatMapValues<Value2>(_ transform: (Value) throws -> [Value2]) rethrows -> [Key:Value2] {
        return try flatMapDict { entry in
            return try transform(entry.value).map { newValue in (entry.key, newValue) }
        }
    }
    
    func flatMapDict<Key2: Hashable, Value2>(_ transform: ((key: Key, value: Value)) throws -> (Key2, Value2)?) rethrows -> [Key2:Value2] {
        return Dictionary<Key2, Value2>(uniqueKeysWithValues: try flatMap(transform))
    }
    
    func flatMapDict<Key2: Hashable, Value2>(_ transform: ((key: Key, value: Value)) throws -> [(Key2, Value2)]) rethrows -> [Key2:Value2] {
        return Dictionary<Key2, Value2>(uniqueKeysWithValues: try flatMap(transform))
    }
}
