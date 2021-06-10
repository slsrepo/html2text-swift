// Python docs: https://docs.python.org/2/library/stdtypes.html#mapping-types-dict
//
// Most frequently used:
//   12 dict.get
//    4 dict.fromkeys
//    2 dict.keys
//    1 dict.iteritems
//    1 dict.has_key
//
// >>> filter(lambda s: not s.startswith("_"), dir({}))
//   clear: Implemented.
//   copy
//   fromkeys: Implemented.
//   get: Implemented.
//   has_key: Implemented as hasKey.
//   items: Implemented.
//   iteritems
//   iterkeys
//   itervalues
//   keys: Already in Swift (instance variable, not method).
//   pop: Implemented.
//   popitem: Implemented.
//   setdefault
//   update
//   values: Already in Swift (instance variable, not method).
//   viewitems
//   viewkeys
//   viewvalues

public typealias dict = Swift.Dictionary

public extension Dictionary {
    mutating func clear() {
        self.removeAll()
    }

    func get(_ key: Key) -> Value? {
        return self[key]
    }

    func hasKey(_ key: Key) -> Bool {
        if let _ = self.get(key) {
            return true
        }
        return false
    }

    func has_key(_ key: Key) -> Bool {
        return hasKey(key)
    }

    mutating func pop(_ key: Key) -> Value? {
        if let val = self.get(key) {
            self.removeValue(forKey: key)
            return val
        }
        return nil
    }

    mutating func popItem() -> (Key, Value)? {
        if self.count == 0 {
            return nil
        }
        let key = Array(self.keys)[0]
        let value = self.pop(key)!
        return (key, value)
    }

    mutating func popitem() -> (Key, Value)? {
        return popItem()
    }

    func items() -> [(Key, Value)] {
        var ret: [(Key, Value)] = []
        for (key, value) in zip(self.keys, self.values) {
            ret.append((key, value))
        }
        return ret
    }

    static func fromKeys(_ sequence: [Key], _ defaultValue: Value) -> [Key: Value]{
        var dict = [Key: Value]()
        for key in sequence {
            dict[key] = defaultValue
        }
        return dict
    }

    static func fromkeys(_ sequence: [Key], _ defaultValue: Value) -> [Key: Value] {
        return fromKeys(sequence, defaultValue)
    }

    func copy() -> [Key: Value] {
        return self
    }
}
