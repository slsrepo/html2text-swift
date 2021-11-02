// Usage:
//
//   var set1 = Set([0, 1, 2])
//   set1.add(3)
//   set1.add(3)
//   assert(set1 == Set([0, 1, 2, 3]))
//
//   var set2 = Set([2, 4, 8, 16])
//   assert(set1 + set2 == Set([0, 1, 2, 3, 4, 8, 16]))
//   assert(set1 - set2 == Set([0, 1, 3]))
//   assert(set1 & set2 == Set([2]))
//
//   assert(Set([1, 1, 1, 2, 2, 3, 3, 4]) == Set([1, 2, 3, 4]))

extension Set: Comparable {
}

// Implement Comparable (allows for "if set1 < set2 { … }")
public func < <T: Hashable>(lhs: Set<T>, rhs: Set<T>) -> Bool {
    return lhs.isStrictSubset(of: rhs)
}

public extension Set {
    mutating func add(element: Element) {
        self.insert(element)
    }

    mutating func discard(element: Element) {
        self.remove(element)
    }

    mutating func clear() {
        self.removeAll()
    }

    func isDisjoint(_ other: Set<Element>) -> Bool {
        return self.isDisjoint(with: other)
    }

    // Lowercase name for Python compatibility.
    func isdisjoint(_ other: Set<Element>) -> Bool {
        return self.isDisjoint(with: other)
    }

    // Implement CollectionType
    mutating func append(_ element: Element) {
        self.add(element: element)
    }
}

public func + <T: Hashable>(lhs: Set<T>, rhs: Set<T>) -> Set<T> {
    return lhs.union(rhs)
}

public func - <T: Hashable>(lhs: Set<T>, rhs: Set<T>) -> Set<T> {
    return lhs.subtracting(rhs)
}

public func & <T: Hashable>(lhs: Set<T>, rhs: Set<T>) -> Set<T> {
    return lhs.intersection(rhs)
}

public func | <T: Hashable>(lhs: Set<T>, rhs: Set<T>) -> Set<T> {
    return lhs + rhs
}

public func += <T: Hashable>( lhs: inout Set<T>, rhs: Set<T>) -> Set<T> {
    return lhs.union(rhs)
}

public func |= <T: Hashable>( lhs: inout Set<T>, rhs: Set<T>) -> Set<T> {
    return lhs.union(rhs)
}

public func &= <T: Hashable>( lhs: inout Set<T>, rhs: Set<T>) -> Set<T> {
    return lhs.intersection(rhs)
}

/* public func += <T: Hashable>( lhs: inout Set<T>, rhs: T) -> Set<T> {
    return lhs.insert(rhs)
} */

public func -= <T: Hashable>( lhs: inout Set<T>, rhs: Set<T>) -> Set<T> {
    return lhs.subtracting(rhs)
}

/* public func -= <T: Hashable>( lhs: inout Set<T>, rhs: T) -> Set<T> {
    return lhs.remove(rhs)
} */

// For Python compatibility.
public func set<T: Hashable>() -> Set<T> {
    return Set()
}

// For Python compatibility.
public func set<T: Hashable>(_  initialArray: [T]) -> Set<T> {
    return Set(initialArray)
}

// For Python compatibility.
public func set<T: Hashable>(_  initialSet: Set<T>) -> Set<T> {
    return Set(initialSet)
}
