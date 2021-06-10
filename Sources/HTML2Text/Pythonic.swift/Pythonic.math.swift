// Python docs: https://docs.python.org/2/library/math.html
//
// Most frequently used:
//   24 math.ceil
//   13 math.log
//   11 math.floor
//    9 math.sqrt
//    9 math.cos
//    6 math.sin
//    4 math.pi
//    3 math.radians
//    2 math.exp
//    1 math.pow
//
// >>> filter(lambda s: not s.startswith("_"), dir(math))
//   acos: Added.
//   acosh: Added.
//   asin: Added.
//   asinh: Added.
//   atan: Added.
//   atan2: Added.
//   atanh: Added.
//   ceil: Added.
//   copysign: Added.
//   cos: Added.
//   cosh: Added.
//   degrees: Added.
//   e: Added.
//   erf: Added.
//   erfc: Added.
//   exp: Added.
//   expm1: Added.
//   fabs: Added.
//   factorial: Added.
//   floor: Added.
//   fmod: Added.
//   frexp: TODO.
//   fsum: TODO.
//   gamma: TODO.
//   hypot: Added.
//   isinf: TODO.
//   isnan: TODO.
//   ldexp: Added.
//   lgamma: Added.
//   log: Added.
//   log10: Added.
//   log1p: Added.
//   modf: TODO.
//   pi: Added.
//   pow: Added.
//   radians: Added.
//   sin: Added.
//   sinh: Added.
//   sqrt: Added.
//   tan: Added.
//   tanh: Added.
//   trunc: Added.

import Darwin

/* public protocol FloatArithmetic: ExpressibleByFloatLiteral {
    static func + (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Self) -> Self
    static func / (lhs: Self, rhs: Self) -> Self
    static func % (lhs: Self, rhs: Self) -> Self
    init(_ value: Double)
    init(_ value: Float)
}

extension Double: FloatArithmetic {
} */

public class math {
    public class var e: Double { return 2.718281828459045 }
    public class var pi: Double { return Darwin.acos(-1.0) }

    public class func acos(_ arg1: Double) -> Double {
        return Darwin.acos(arg1)
    }

    public class func acosh(_ arg1: Double) -> Double {
        return Darwin.acosh(arg1)
    }

    public class func asin(_ arg1: Double) -> Double {
        return Darwin.asin(arg1)
    }

    public class func asinh(_ arg1: Double) -> Double {
        return Darwin.asinh(arg1)
    }

    public class func atan(_ arg1: Double) -> Double {
        return Darwin.atan(arg1)
    }

    public class func atan2(_ arg1: Double, _ arg2: Double) -> Double {
        return Darwin.atan2(arg1, arg2)
    }

    public class func atanh(_ arg1: Double) -> Double {
        return Darwin.atanh(arg1)
    }

    public class func ceil(_ arg1: Double) -> Double {
        return Darwin.ceil(arg1)
    }

    public class func copysign(_ arg1: Double, _ arg2: Double) -> Double {
        return Darwin.copysign(arg1, arg2)
    }

    public class func cos(_ arg1: Double) -> Double {
        return Darwin.cos(arg1)
    }

    public class func cosh(_ arg1: Double) -> Double {
        return Darwin.cosh(arg1)
    }

    public class func erf(_ arg1: Double) -> Double {
        return Darwin.erf(arg1)
    }

    public class func erfc(_ arg1: Double) -> Double {
        return Darwin.erfc(arg1)
    }

    public class func exp(arg1: Double) -> Double {
        return Darwin.exp(arg1)
    }

    public class func expm1(arg1: Double) -> Double {
        return Darwin.expm1(arg1)
    }

    public class func fabs(arg1: Double) -> Double {
        return Darwin.fabs(arg1)
    }

    public class func floor(arg1: Double) -> Double {
        return Darwin.floor(arg1)
    }

    public class func fmod(arg1: Double, _ arg2: Double) -> Double {
        return Darwin.fmod(arg1, arg2)
    }

    public class func hypot(arg1: Double, _ arg2: Double) -> Double {
        return Darwin.hypot(arg1, arg2)
    }

    public class func ldexp(arg1: Double, arg2: CInt) -> Double {
        return Darwin.ldexp(arg1, arg2)
    }

    public class func lgamma(arg1: Double) -> Double {
        return Darwin.lgamma(arg1)
    }

    public class func log(arg1: Double) -> Double {
        return Darwin.log(arg1)
    }

    public class func log10(arg1: Double) -> Double {
        return Darwin.log10(arg1)
    }

    public class func log1p(arg1: Double) -> Double {
        return Darwin.log1p(arg1)
    }

    public class func pow(arg1: Double, _ arg2: Double) -> Double {
        return arg1 ** arg2
    }

    public class func sin(arg1: Double) -> Double {
        return Darwin.sin(arg1)
    }

    public class func sinh(arg1: Double) -> Double {
        return Darwin.sinh(arg1)
    }

    public class func sqrt(arg1: Double) -> Double {
        return Darwin.sqrt(arg1)
    }

    public class func tan(arg1: Double) -> Double {
        return Darwin.tan(arg1)
    }

    public class func tanh(arg1: Double) -> Double {
        return Darwin.tanh(arg1)
    }

    public class func trunc(arg1: Double) -> Double {
        return Darwin.trunc(arg1)
    }

    public class func degrees(r: Double) -> Double {
        return r / pi * 180
    }
    public class func radians(d: Double) -> Double {
        return d / 180 * pi
    }

    private class func integerToDouble<T: ExpressibleByIntegerLiteral>(n: T) -> Double {
        switch n {
        case let x as Int8:
            return Double(x)
        case let x as Int16:
            return Double(x)
        case let x as Int32:
            return Double(x)
        case let x as Int64:
            return Double(x)
        case let x as Int:
            return Double(x)
        case let x as UInt8:
            return Double(x)
        case let x as UInt16:
            return Double(x)
        case let x as UInt32:
            return Double(x)
        case let x as UInt64:
            return Double(x)
        case let x as UInt:
            return Double(x)
        default:
            return 0
        }
    }

    /* public class func factorial<T: BinaryInteger>(n: T) -> Double {
        assert(n >= 0, "factorial() not defined for negative values")
        if n < 2 {
            return 1
        }
        var r: Double = 2
        for _ in 3...n {
            r = r * integerToDouble(n)
        }
        return r
    }

    public class func factorial<T: BinaryInteger>(num: T) -> T {
        assert(num >= 0, "factorial() not defined for negative values")
        if num < 2 {
            return 1
        }
        var result: T = 2
        for i in 3...num {
            result *= i
        }
        return result
    } */
}
