// Python docs: https://docs.python.org/2/library/stdtypes.html#sequence-types-str-unicode-list-tuple-bytearray-buffer-xrange
//
// Most frequently used:
//    2 list.sort
//    2 list.pop
//    2 list.append
//    1 list.reverse
//    1 list.remove
//    1 list.insert
//
// >>> filter(lambda s: not s.startswith("_"), dir([]))
//   append: Already in Swift.
//   count: Added.
//   extend: Already in Swift.
//   index: Added.
//   insert: Failed to add. (TODO)
//   pop: Added.
//   remove: Added.
//   reverse: Added as "reverseInPlace" to avoid name collision with built-in Array.reverse.
//   sort: Failed to add. Name collision with built-in Array.sort. (TODO)

public extension Array {
    mutating func clear() {
        self.removeAll()
    }

    mutating func reverseInPlace() {
        self.reverse()
    }

    mutating func count<T>(_ element: T) -> Int where T: Equatable {
        if element is Array.Element {
            return Swift.unsafeBitCast(self, to: [T].self).filter({ $0 == element }).count
        }
        return 0
    }
    
    mutating func remove<T>(_ element: T) where T: Equatable {
        if let i = index(element) {
            self.remove(at: i)
        }
    }

    func index<T>(_ element: T) -> Int? where T: Equatable {
        if element is Array.Element {
            if let idx = Swift.unsafeBitCast(self, to: [T].self).firstIndex(of: element) {
                return idx
            }
        }
        return nil
    }

    mutating func pop(_ index: Int?) -> Array.Element? {
        let i = index ?? self.count - 1
        guard self.count > 0 && i >= 0 && i < self.count else {
            return nil
        }
        defer { self.remove(at: i) }
        return self[i]
    }

    mutating func pop() -> Array.Element? {
        return self.pop(nil)
    }
}
