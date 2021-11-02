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

#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

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
    public class var pi: Double { 
        #if os(Linux)
            return Glibc.acos(-1.0)
        #else
            return Darwin.acos(-1.0)
        #endif
    }

    public class func acos(_ arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.acos(arg1)
        #else
            return Darwin.acos(arg1)
        #endif
    }

    public class func acosh(_ arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.acosh(arg1)
        #else
            return Darwin.acosh(arg1)
        #endif
    }

    public class func asin(_ arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.asin(arg1)
        #else
            return Darwin.asin(arg1)
        #endif
    }

    public class func asinh(_ arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.asinh(arg1)
        #else
            return Darwin.asinh(arg1)
        #endif
    }

    public class func atan(_ arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.atan(arg1)
        #else
            return Darwin.atan(arg1)
        #endif
    }

    public class func atan2(_ arg1: Double, _ arg2: Double) -> Double {
        #if os(Linux)
            return Glibc.atan2(arg1, arg2)
        #else
            return Darwin.atan2(arg1, arg2)
        #endif
    }

    public class func atanh(_ arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.atanh(arg1)
        #else
            return Darwin.atanh(arg1)
        #endif
    }

    public class func ceil(_ arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.ceil(arg1)
        #else
            return Darwin.ceil(arg1)
        #endif
    }

    public class func copysign(_ arg1: Double, _ arg2: Double) -> Double {
        #if os(Linux)
            return Glibc.copysign(arg1, arg2)
        #else
            return Darwin.copysign(arg1, arg2)
        #endif
    }

    public class func cos(_ arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.cos(arg1)
        #else
            return Darwin.cos(arg1)
        #endif
    }

    public class func cosh(_ arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.cosh(arg1)
        #else
            return Darwin.cosh(arg1)
        #endif
    }

    public class func erf(_ arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.erf(arg1)
        #else
            return Darwin.erf(arg1)
        #endif
    }

    public class func erfc(_ arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.erfc(arg1)
        #else
            return Darwin.erfc(arg1)
        #endif
    }

    public class func exp(arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.exp(arg1)
        #else
            return Darwin.exp(arg1)
        #endif
    }

    public class func expm1(arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.expm1(arg1)
        #else
            return Darwin.expm1(arg1)
        #endif
    }

    public class func fabs(arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.fabs(arg1)
        #else
            return Darwin.fabs(arg1)
        #endif
    }

    public class func floor(arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.floor(arg1)
        #else
            return Darwin.floor(arg1)
        #endif
    }

    public class func fmod(arg1: Double, _ arg2: Double) -> Double {
        #if os(Linux)
            return Glibc.fmod(arg1, arg2)
        #else
            return Darwin.fmod(arg1, arg2)
        #endif
    }

    public class func hypot(arg1: Double, _ arg2: Double) -> Double {
        #if os(Linux)
            return Glibc.hypot(arg1, arg2)
        #else
            return Darwin.hypot(arg1, arg2)
        #endif
    }

    public class func ldexp(arg1: Double, arg2: CInt) -> Double {
        #if os(Linux)
            return Glibc.ldexp(arg1, arg2)
        #else
            return Darwin.ldexp(arg1, arg2)
        #endif
    }

    public class func lgamma(arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.lgamma(arg1)
        #else
            return Darwin.lgamma(arg1)
        #endif
    }

    public class func log(arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.log(arg1)
        #else
            return Darwin.log(arg1)
        #endif
    }

    public class func log10(arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.log10(arg1)
        #else
            return Darwin.log10(arg1)
        #endif
    }

    public class func log1p(arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.log1p(arg1)
        #else
            return Darwin.log1p(arg1)
        #endif
    }

    public class func pow(arg1: Double, _ arg2: Double) -> Double {
        return arg1 ** arg2
    }

    public class func sin(arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.sin(arg1)
        #else
            return Darwin.sin(arg1)
        #endif
    }

    public class func sinh(arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.sinh(arg1)
        #else
            return Darwin.sinh(arg1)
        #endif
    }

    public class func sqrt(arg1: Double) -> Double {
        #if os(Linux)
            return Glibc.sqrt(arg1)
        #else
            return Darwin.sqrt(arg1)
        #endif
    }

    public class func tan(arg1: Double) -> Double {
        #if os(Linux)
        return Glibc.tan(arg1)
        #else
            return Darwin.tan(arg1)
        #endif
    }

    public class func tanh(arg1: Double) -> Double {
        #if os(Linux)
        return Glibc.tanh(arg1)
        #else
            return Darwin.tanh(arg1)
        #endif
    }

    public class func trunc(arg1: Double) -> Double {
        #if os(Linux)
        return Glibc.trunc(arg1)
        #else
            return Darwin.trunc(arg1)
        #endif
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
