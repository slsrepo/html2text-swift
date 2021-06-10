// Python docs: https://docs.python.org/2/library/stdtypes.html
//
// >>> filter(lambda s: not s.startswith("_"), dir(1.1))
//   as_integer_ratio
//   conjugate
//   fromhex
//   hex
//   imag
//   is_integer: Implemented.
//   real

public typealias float = Swift.Double

public extension Double {
    func isInteger() -> Bool {
        return math.floor(arg1: self) == self
    }

    func isr() -> Bool {
        return self.isInteger()
    }
}

public extension Float {
    func isInteger() -> Bool {
        return math.floor(arg1: Double(self)) == Double(self)
    }

    func is_integer() -> Bool {
        return self.isInteger()
    }
}
