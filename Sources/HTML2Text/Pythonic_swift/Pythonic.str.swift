// Python docs: https://docs.python.org/2/library/string.html
// also: https://docs.python.org/2/library/stdtypes.html#string-methods
//
// Most frequently used:
//   19 str.replace
//    9 str.split
//    4 str.join
//    2 str.startswith
//    2 str.lower
//    1 str.upper
//    1 str.strip
//    1 str.decode
//
// >>> filter(lambda s: not s.startswith("_"), dir(""))
//   capitalize: Added.
//   center: Added.
//   count: Added.
//   decode: TODO.
//   encode: TODO.
//   endswith: Added.
//   expandtabs: Added.
//   find: Added.
//   format: TODO.
//   index: Added.
//   isalnum: Added.
//   isalpha: Added.
//   isdigit: Added.
//   islower: Added.
//   isspace: Added.
//   istitle: Added.
//   isupper: Added.
//   join: Added.
//   ljust: Added.
//   lower: Added.
//   lstrip: Added.
//   partition: Added.
//   replace: Added.
//   rfind: Added.
//   rindex: Added.
//   rjust: Added.
//   rpartition: Added.
//   rsplit: Added.
//   rstrip: Added.
//   split: Added.
//   splitlines: Added.
//   startswith: Added.
//   strip: Added.
//   swapcase: Added.
//   title: Added.
//   translate: TODO.
//   upper: Added.
//   zfill: Added.

public typealias str = Swift.String

public extension String {
    func countOf(_ c: Character) -> Int {
        var counter = 0
        /* for ch in self {
            if ch == c {
                counter += 1
            }
        } */
        counter = self.filter { (char) -> Bool in
            char == c
        }.count
        return counter
    }

    func capitalize() -> String {
        if self.count == 0 {
            return self
        }
        
        return self.capitalized
        // return String(String.Index(self[0])).upper() + self[1..<String.Index(self.count)].lower()
    }

    func endsWith(_ suffix: String) -> Bool {
        return self.hasSuffix(suffix)
    }

    func endswith(_ suffix: String) -> Bool {
        return self.endsWith(suffix)
    }

    func join<S: Sequence>(_ strings: S) -> String where S.Element == String {
        return strings.joined(separator: self)
    }

    func lower() -> String {
        return self.lowercased()
    }

    func replace(_ replaceOldString: String, _ withString: String) -> String {
        return self.replacingOccurrences(of: replaceOldString, with: withString)
    }

    func split() -> [String] {
        var strings: [String] = []
        
        for s in re.split(WHITESPACE_REGEXP, self) {
            if s != "" {
                strings += [s]
            }
        }
        
        return strings
    }

    // TODO: More arguments. string.split(s[, sep[, maxsplit]])¶
    func split(_ sep: String) -> [String] {
        return self.split(separator: Character(sep)).map { sub -> String in return String(sub)}
        // return self.components(separatedBy: sep)
    }

    func splitlines() -> [String] {
        var normalized = self.replace("\r\n", "\n").replace("\r", "\n")
        normalized = re.sub("\n$", "", normalized)
        return re.split("\n", normalized)
    }

    func startsWith(_ prefix: String) -> Bool {
        return self.hasPrefix(prefix)
    }

    func startswith(_ prefix: String) -> Bool {
        return self.startsWith(prefix)
    }

    private var HEX_SET: Set<String> {
        return DIGITS_SET + Set(["a", "A", "b", "B", "c", "C", "d", "D", "e", "E", "f", "F"])
    }

    private func isComposedOnlyOfCharacterSet(_ characterSet: Set<String>) -> Bool {
        if self == "" {
            return false
        }
        for ch in self {
            if !characterSet.contains(String(ch)) {
                return false
            }
        }
        return true
    }

    private var WHITESPACE_SET: Set<String> {
        return Set(["\t", "\n", "\r", "\u{11}", "\u{12}", " "])
    }

    func isSpace() -> Bool {
        return self.isComposedOnlyOfCharacterSet(WHITESPACE_SET)
    }

    func isspace() -> Bool {
        return self.isSpace()
    }

    private var ASCII_LOWERCASE_SET: Set<String> {
        return Set(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"])
    }

    func isLower() -> Bool {
        return self.isComposedOnlyOfCharacterSet(ASCII_LOWERCASE_SET)
    }

    func islower() -> Bool {
        return self.isLower()
    }

    private var ASCII_UPPERCASE_SET: Set<String> {
        return Set(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"])
    }

    func isUpper() -> Bool {
        return self.isComposedOnlyOfCharacterSet(ASCII_UPPERCASE_SET)
    }

    func isupper() -> Bool {
        return self.isUpper()
    }

    private var DIGITS_SET: Set<String> {
        return Set(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])
    }

    func isDigit() -> Bool {
        return self.isComposedOnlyOfCharacterSet(DIGITS_SET)
    }

    func isdigit() -> Bool {
        return self.isDigit()
    }

    private var ASCII_ALPHA_SET: Set<String> {
        return ASCII_UPPERCASE_SET + ASCII_LOWERCASE_SET
    }

    func isAlpha() -> Bool {
        return self.isComposedOnlyOfCharacterSet(ASCII_ALPHA_SET)
    }

    func isalpha() -> Bool {
        return self.isAlpha()
    }

    private var ASCII_ALPHANUMERIC_SET: Set<String> {
        return ASCII_ALPHA_SET + DIGITS_SET
    }

    func isAlnum() -> Bool {
        return self.isComposedOnlyOfCharacterSet(ASCII_ALPHANUMERIC_SET)
    }

    func isalnum() -> Bool {
        return self.isAlnum()
    }

    func isTitle() -> Bool {
        return self == self.title()
    }

    func istitle() -> Bool {
        return self.isTitle()
    }

    func swapCase() -> String {
        var returnString = ""
        for ch in self {
            let s = String(ch)
            if s.isLower() {
                returnString += s.upper()
            } else if s.isUpper() {
                returnString += s.lower()
            } else {
                returnString += s
            }
        }
        return returnString
    }

    func swapcase() -> String {
        return self.swapCase()
    }

    var WHITESPACE_REGEXP: String {
        return "[\t\n\r\u{11}\u{12} ]"
    }

    func lstrip(_ pattern: String = "[\t\n\r\u{11}\u{12} ]") -> String {
        return re.sub("^" + pattern + "+", "", self)
    }

    func rstrip(_ pattern: String = "[\t\n\r\u{11}\u{12} ]") -> String {
        return re.sub(pattern + "+$", "", self)
    }

    func strip(_ pattern: String = "") -> String {
        if pattern != "" {
            return self.lstrip(pattern).rstrip(pattern)
        }
        
        return self.lstrip().rstrip()
    }
    

    // NOTE: Not equivalent to Python, but better.
    func title() -> String {
        return self.capitalized
    }

    func upper() -> String {
        return self.uppercased()
    }

    private func _sliceIndexes(_ arg1: Int?, _ arg2: Int?) -> (Int, Int) {
        let length = self.count
        var (start, end) = (0, length)
        if let arg1 = arg1 {
            if arg1 < 0 {
                start = max(length + arg1, 0)
            } else {
                start = min(arg1, length)
            }
        }
        if let arg2 = arg2 {
            if arg2 < 0 {
                end = max(length + arg2, 0)
            } else {
                end = min(arg2, length)
            }
        }
        if start > end {
            return (0, 0)
        }
        return (start, end)
    }

    /// Get a substring using Pythonic string indexing.
    ///
    /// Usage:
    ///
    /// * Python: str[2:4] -> Swift: str[(2, 4)]
    /// * Python: str[2:]  -> Swift: str[(2, nil)]
    /// * Python: str[:2]  -> Swift: str[(nil, 2)]
    subscript (_ args: (Int?, Int?)) -> String {
        let (arg1, arg2) = args
        let (start, end) = _sliceIndexes(arg1, arg2)
        return self[start..<end]
    }

    /// Get a single-character string by Int index.
    subscript(_ index: Int) -> String {
        var i = index
        if i < 0 {
            i += self.count
        }
        return String(self[self.index(self.startIndex, offsetBy: 1)])
    }

    /// Get a substring using an integer range.
    ///
    /// Usage:
    ///
    /// * str[2..<4]
    /// * str[2...4]
    subscript(_ range: Range<Int>) -> String {
//        let range = self.index(self.startIndex, offsetBy: range.startIndex)..<self.index(self.startIndex, offsetBy: range.endIndex)
//        return self.substring(with: range)
        return String(self[self.index(self.startIndex, offsetBy: range.startIndex)..<self.index(self.startIndex, offsetBy: range.endIndex)])
    }

    /// Split the string at the first occurrence of sep, and return a 3-tuple containing the part before the separator, the separator itself, and the part after the separator. If the separator is not found, return a 3-tuple containing the string itself, followed by two empty strings.
    func partition(_ separator: String) -> (String, String, String) {
        let split: [String] = self.split(separator: Character(separator)).map { sub -> String in return String(sub)}
        let firstpart = split.first!
        let secondpart = split[1]
        return (firstpart, separator, secondpart)
    }

    // Split the string at the last occurrence of sep, and return a 3-tuple containing the part before the separator, the separator itself, and the part after the separator. If the separator is not found, return a 3-tuple containing two empty strings, followed by the string itself.
    func rpartition(_ separator: String) -> (String, String, String) {
        let rindex = self.lastIndex(of: Character(separator))
        // rindex(separator)
        if rindex != nil {
            return ("", "", self)
        }
        let array = self.split(separator: Character(separator)).map { sub -> String in return String(sub)}
        if array.count == 2 {
            return (array.first!, separator, array.last!)
        } else {
            let firstpart = String(self[self.startIndex..<rindex!])
            return (firstpart, separator, array.last!)
        }
    }

    // justification
    func ljust(_ width: Int, _ fillchar: Character = " ") -> String {
        let length = self.count
        if length >= width { return self }
        return self + String(repeating: fillchar, count: width - length)
    }

    func rjust(_ width: Int, _ fillchar: Character = " ") -> String {
        let length = self.count
        if length >= width { return self }
        return String(repeating: fillchar, count: width - length) + self
    }

    func center(_ width: Int, _ fillchar: Character = " ") -> String {
        let length = self.count
        let oddShift = length % 2 == 1 ? 0.5 : 0.0 // Python is weird about string centering
        let left = Int((Double(width) + Double(length)) / 2.0 + oddShift)
        return self.ljust(left, fillchar).rjust(width, fillchar)
    }

    func expandTabs(_ tabSize: Int) -> String {
        return self.replace("\t", " " * tabSize)
    }

    func expandTabs() -> String {
        return self.expandTabs(8)
    }

    func expandtabs(_ tabSize: Int) -> String {
        return self.expandTabs(tabSize)
    }

    func expandtabs() -> String {
        return self.expandTabs()
    }

    // TODO: Cannot use Foundation String functions here, since string length
    //       according to Foundation can differ from string length according
    //       to Swift.
    func find(_ sub: String) -> Int {
        let subArr = Array(sub)
        if subArr.count == 0 {
            return 0
        }
        let stringArr = Array(self)
        if subArr.count > stringArr.count {
            return -1
        }
        for i in 0..<stringArr.count - subArr.count + 1 {
            if stringArr[i] == subArr[0] {
                let readAhead = stringArr[i..<i + subArr.count]
                if readAhead.elementsEqual(subArr) {
                    return i
                }
            }
        }
        return -1
    }

    /* func rfind(_ sub: String) -> Int {
        if sub.count == 1 {
            var rindex = self.endIndex
            for character in self.reversed() {
                rindex = rindex.predecessor()
                if character == Character(sub) {
                    return self.startIndex.distanceTo(rindex)
                }
            }
        }
        
        if self.contains(sub) {
            var copy = self
            let array = self.split(sub)
            if let range = copy.range(of: array.last!) {
                copy.removeSubrange(range)
            }
            let rindex = copy.endIndex.advance(-sub.count)
            return self.startIndex.distanceTo(rindex)
        }
        return -1
    } */

    func index(_ sub: String) -> Int {
        return self.find(sub)
    }

    /* func rindex(_ sub: String) -> Int {
        return self.rfind(sub)
    } */
    
    func wrap(_ width: Int) -> [String] {
        var counter = 0
        var result: [String] = []
        let lastIndex: String.Index = self.startIndex
        
        while counter != self.count {
            let currentIndex: String.Index = self.index(lastIndex, offsetBy: width)
            let string = String(self[lastIndex..<currentIndex])
            result.append(string)
            
            counter = counter + width
        }
        return result
    }

    func zfill(_ length: Int) -> String {
        return "0" * (length - self.count) + self
    }

    // Python: if "foo" in "foobar": …
    // Pythonic.swift: if "foo".in(foobar) { … }
    func `in`(_ s: String) -> Bool {
        /* if !self {
            return true
        } */
        return s.find(self) != -1
    }

    func join(_ s: [String]) -> String {
        return s.joined(separator: self)
    }
}

public func * (lhs: Int, rhs: String) -> String {
    if lhs < 0 {
        return ""
    }
    var ret = ""
    for _ in 0..<lhs {
        ret += rhs
    }
    return ret
}

public func * (lhs: String, rhs: Int) -> String {
    return rhs * lhs
}
