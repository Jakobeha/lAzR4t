//
//  List.swift
//  lAzR4t
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import Foundation

///A non-empty linked list
enum List<T> {
    case empty
    indirect case cons(head: T, rest: List<T>)
    
    ///Shorthand operator for `cons`
    static func +(_ head: T, _ rest: List<T>) -> List<T> {
        return .cons(head: head, rest: rest)
    }
    
    static func +(_ a: List<T>, _ b: List<T>) -> List<T> {
        switch a {
        case .empty:
            return b
        case .cons(let aHead, let aRest):
            return .cons(head: aHead, rest: aRest + b)
        }
    }
    
    var isEmpty: Bool {
        switch self {
        case .empty:
            return true
        case .cons(_, _):
            return false
        }
    }
    
    var last: T? {
        switch self {
        case .empty:
            return nil
        case .cons(head: let last, rest: .empty):
            return last
        case .cons(_, let rest):
            return rest.last
        }
    }
    
    var count: Int {
        switch self {
        case .empty:
            return 0
        case .cons(_, let rest):
            return 1 + rest.count
        }
    }
    
    var toArray: [T] {
        let count = self.count
        var curRes = [T]()
        curRes.reserveCapacity(count)
        var remaining = self
        for i in 0..<count {
            switch remaining {
            case .empty:
                fatalError("Remaining list empty before remaining length 0")
            case .cons(head: let next, rest: let newRemaining):
                curRes[i] = next
                remaining = newRemaining
                break
            }
        }
        return curRes
    }
    
    init(fromArray array: [T]) {
        var curSelf = List.empty
        for item in array {
            curSelf = .cons(head: item, rest: curSelf)
        }
        self = curSelf
    }
    
    func map<T2>(_ transform: (T) throws -> T2) rethrows -> List<T2> {
        switch self {
        case .empty:
            return .empty
        case .cons(let head, let rest):
            return .cons(head: try transform(head), rest: try rest.map(transform))
        }
    }
    
    func flatMap<T2>(_ transform: (T) throws -> T2?) rethrows -> List<T2> {
        switch self {
        case .empty:
            return .empty
        case .cons(let head, let rest):
            let newRest = try rest.flatMap(transform)
            switch try transform(head) {
            case .none:
                return newRest
            case .some(let newHead):
                return .cons(head: newHead, rest: newRest)
            }
        }
    }
    
    func filter(_ satisfies: (T) throws -> Bool) rethrows -> List<T> {
        switch self {
        case .empty:
            return .empty
        case .cons(let head, let rest):
            let newRest = try rest.filter(satisfies)
            if try !satisfies(head) {
                return newRest
            } else {
                return .cons(head: head, rest: newRest)
            }
        }
    }
    
    func forEach(_ apply: (T) throws -> Void) rethrows {
        switch self {
        case .empty:
            break
        case .cons(let head, let rest):
            try apply(head)
            try rest.forEach(apply)
            break
        }
    }
    
    func contains(where satisfies: (T) throws -> Bool) rethrows -> Bool {
        switch self {
        case .empty:
            return false
        case .cons(let head, let rest):
            return try satisfies(head) || rest.contains(where: satisfies)
        }
    }
}

extension List where T: Equatable {
    static func ==(_ a: List<T>, _ b: List<T>) -> Bool {
        switch (a, b) {
        case (.empty, .empty):
            return true
        case (.empty, .cons(_, _)):
            return false
        case (.cons(_, _), .empty):
            return false
        case (.cons(head: let aHead, rest: let aRest), .cons(head: let bHead, rest: let bRest)):
            return aHead == bHead && aRest == bRest
        }
    }
    
    func contains(_ item: T) -> Bool {
        return contains { $0 == item }
    }
    
    ///Throws an error if the item isn't removed
    func removeOne(_ item: T) throws -> List<T> {
        switch self {
        case .empty:
            throw ListError.itemNotRemoved
        case .cons(let head, let rest):
            if head == item {
                return rest
            } else {
                return .cons(head: head, rest: try rest.removeOne(item))
            }
        }
    }
    ///Throws an error if the item isn't replaced
    func replaceOne(_ oldItem: T, with newItem: T) throws -> List<T> {
        switch self {
        case .empty:
            throw ListError.itemNotReplaced
        case .cons(let head, let rest):
            if head == oldItem {
                return .cons(head: newItem, rest: rest)
            } else {
                return .cons(head: head, rest: try rest.replaceOne(oldItem, with: newItem))
            }
        }
    }
}

enum ListError: Error {
    case itemNotRemoved
    case itemNotReplaced
}
