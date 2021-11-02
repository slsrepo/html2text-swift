// Python docs: https://docs.python.org/2/library/re.html
//
// Most frequently used:
//  346 re.search
//  252 re.match
//  218 re.compile
//  217 re.sub
//   28 re.split
//   26 re.findall
//   26 re.IGNORECASE
//   17 re.escape
//   16 re.VERBOSE
//    9 re.finditer
//
// >>> filter(lambda s: not s.startswith("_"), dir(re))
//   DEBUG
//   DOTALL
//   I
//   IGNORECASE
//   L
//   LOCALE
//   M
//   MULTILINE
//   S
//   Scanner
//   T
//   TEMPLATE
//   U
//   UNICODE
//   VERBOSE
//   X
//   compile
//   copy_reg
//   error
//   escape
//   findall
//   finditer
//   match
//   purge
//   search
//   split
//   sre_compile
//   sre_parse
//   sub
//   subn
//   sys
//   template

import Foundation

public class RegularExpressionMatch {
    private var matchedStrings: [String] = []

    public init(_ matchedStrings: [String]) {
        self.matchedStrings.append(contentsOf: matchedStrings)
    }

    public func groups() -> [String] {
        return Array(self.matchedStrings.dropFirst())
    }

    public func group( _ i: Int) -> String? {
        if self.matchedStrings.count > i {
        return self.matchedStrings[i]
        } else {
            return nil
        }
    }

    public var boolValue: Bool {
        return self.matchedStrings.count != 0
    }

    public subscript ( _ index: Int) -> String? {
        return self.group(index)
    }
}

public class re {
    public class func search( _ pattern: String, _ string: String) -> RegularExpressionMatch {
        var matchedStrings = [String]()
        if pattern == "" {
            return RegularExpressionMatch(matchedStrings)
        }
        // NOTE: Must use NSString:s below to avoid off-by-one issues when countElements(swiftString) != nsString.length.
        //       Example case: countElements("\r\n") [1] != ("\r\n" as NSString).length [2]
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return RegularExpressionMatch(matchedStrings)
        }
        let matches = regex.matches(in: string, options: [], range: NSRange(location: 0, length: (string as NSString).length))
        for match in matches {
            for i in 0..<match.numberOfRanges {
                let range = match.range(at: i)
                var matchString = ""
                if range.location != Int.max {
                    matchString = (string as NSString).substring(with: range)
                }
                matchedStrings += [matchString]
            }
        }
        return RegularExpressionMatch(matchedStrings)
    }

    public class func match( _ pattern: String, _ string: String) -> RegularExpressionMatch {
        return re.search(pattern.startsWith("^") ? pattern : "^" + pattern, string)
    }

    public class func split( _ pattern: String, _ string: String) -> [String] {
        if pattern == "" {
            return [string]
        }
        var returnedMatches = [String]()
        // NOTE: Must use NSString:s below to avoid off-by-one issues when countElements(swiftString) != nsString.length.
        //       Example case: countElements("\r\n") [1] != ("\r\n" as NSString).length [2]
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let matches = regex.matches(in: string, options: [], range: NSMakeRange(0, (string as NSString).length))
            var includeDelimiters = false
            // Heuristic detection of capture group(s) to try matching behaviour of Python's re.split. Room for improvement.
            if "(".`in`(pattern.replace("\\(", "").replace("(?", "")) {
                includeDelimiters = true
            }
            var previousRange: NSRange?
            var lastLocation = 0
            for match in matches {
                if includeDelimiters {
                    if let previousRange = previousRange {
                        let previousString: String = (string as NSString).substring(with: NSMakeRange(previousRange.location, previousRange.length))
                        returnedMatches += [previousString]
                    }
                }
                let matchedString: String = (string as NSString).substring(with: NSMakeRange(lastLocation, match.range.location - lastLocation))
                returnedMatches += [matchedString]
                lastLocation = match.range.location + match.range.length
                previousRange = match.range
            }
            if includeDelimiters {
                if let previousRange = previousRange {
                    let previousString: String = (string as NSString).substring(with: NSMakeRange(previousRange.location, previousRange.length))
                    returnedMatches += [previousString]
                }
            }
            let matchedString: String = (string as NSString).substring(with: NSMakeRange(lastLocation, (string as NSString).length - lastLocation))
            returnedMatches += [matchedString]
        }
        return returnedMatches
    }

    public class func sub( _ pattern: String, _ repl: String, _ string: String) -> String {
        var replaceWithString = repl
        for i in 0...9 {
            replaceWithString = replaceWithString.replace("\\\(i)", "$\(i)")
        }
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            return regex.stringByReplacingMatches(in: string, options: [], range: NSMakeRange(0, (string as NSString).length), withTemplate: replaceWithString)
        }
        return string
    }
}
