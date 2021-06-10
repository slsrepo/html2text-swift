//
//  StringHelpers.swift
//  Prev
//
//  Created by Shahaf Levi on 27/11/2015.
//  Copyright © 2015 Sl's Repository Ltd. All rights reserved.
//

import Foundation

extension String {
    var nsLength: Int {
        return (self as NSString).length
    }
    
    /// Converts a Range<String.Index> to an NSRange.
    /// http://stackoverflow.com/a/30404532/6669540
    ///
    /// - parameter range: The Range<String.Index>.
    ///
    /// - returns: The equivalent NSRange.
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        // return NSRange(location: self.distance(from: utf16.startIndex, to: from!),
                       // length: self.distance(from: from!, to: to!))
        return NSRange(range, in: self)
    }

    /// Converts a String to a NSRegularExpression.
    ///
    /// - returns: The NSRegularExpression.
    func toRegex() -> NSRegularExpression {
        var pattern: NSRegularExpression = NSRegularExpression()

        do {
            try pattern = NSRegularExpression(pattern: self, options: .anchorsMatchLines)
        } catch {
            print(error)
        }

        return pattern
    }

    /// Converts a NSRange to a Range<String.Index>.
    /// http://stackoverflow.com/a/30404532/6669540
    ///
    /// - parameter range: The NSRange.
    ///
    /// - returns: The equivalent Range<String.Index>.
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        // return from ..< to
        return Range<String.Index>(nsRange, in: self)
    }
    
    func rangesOfString(s: String) -> [Range<String.Index>] {
        let re = try! NSRegularExpression(pattern: NSRegularExpression.escapedPattern(for: s), options: [])
        let checkRange = NSRange(startIndex..<endIndex, in: self)
        return re.matches(in: self, options: [], range: checkRange).compactMap { range(from: $0.range) }
    }
    
    func nsRangesOfString(s: String) -> [NSRange] {
        let re = try! NSRegularExpression(pattern: NSRegularExpression.escapedPattern(for: s), options: [])
        let checkRange = NSRange(startIndex..<endIndex, in: self)
        return re.matches(in: self, options: [], range: checkRange).compactMap { $0.range }
    }
    
    func stringByAddingPercentEncodingForFormUrlencoded() -> String? {
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: "-._* ")
        
        return self.addingPercentEncoding(withAllowedCharacters: characterSet)?.replacingOccurrences(of: " ", with: "+")
    }
    
   
	func chopPrefix(_ prefix: String) -> String? {
		if self.unicodeScalars.starts(with: prefix.unicodeScalars) {
			return String(self[self.index(self.startIndex, offsetBy: prefix.count)...])
		} else {
			return nil
		}
	}
	
	 /* func chopSuffix(_ suffix: String) -> String? {
		if self.unicodeScalars.ends(with: suffix.unicodeScalars) {
			return String(self[...self.index(self.endIndex, offsetBy: -suffix.count)])
		} else {
			return nil
		}
	} */
    
    func chopSuffix(_ suffix: String) -> String? {
        let suffixR = String(suffix.reversed())
        let selfR = String(self.reversed())
        let result = selfR.chopPrefix(suffixR)
        
        if result != nil {
            return String(result!.reversed())
        } else {
            return nil
        }
    }
    
	func containsDotDot() -> Bool {
		for idx in self.indices {
			if self[idx] == "." && idx < self.index(before: self.endIndex) && self[self.index(after: idx)] == "." {
				return true
			}
		}
		return false
	}
	
	func shellescape() -> String {
		return self.replacingOccurrences(of: "[\"\"]", with: "\\$1", options: .regularExpression)
	}

    
    func substring(startingAt: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: startingAt)...])
    }
    
    func substring(endingAt: Int) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: endingAt)])
    }
    
    func substring(at range: NSRange) -> String? {
        guard range.location != NSNotFound else {
            return nil
        }
        
        return NSString(string: self).substring(with: range)
    }
    
    func matches(_ pattern: String) -> Bool {
        return self.range(of: pattern, options: .regularExpression) != nil
    }
    
    func captureGroups(of pattern: NSRegularExpression) -> [[String]] {
        let range = NSRange((self.startIndex..<self.endIndex), in: self)
        
        return pattern.matches(in: self, options: [], range: range).map { (result) -> [String] in
            var arr: [String] = []
            
            for match in 0..<result.numberOfRanges {
                let sub = self.substring(at: result.range(at: match)) ?? ""
                
                arr.append(sub)
            }
            
            return arr
        }
    }
}

extension NSString {
    func paragraphRange(at location: Int) -> NSRange {
        return paragraphRange(for: NSRange(location: location, length: 0))
    }
    
    func lineRange(at location: Int) -> NSRange {
        return lineRange(for: NSRange(location: location, length: 0))
    }
    
    func rangesOfString(s: String) -> [NSRange] {
        let re = try! NSRegularExpression(pattern: NSRegularExpression.escapedPattern(for: s), options: [])
        let checkRange = NSMakeRange(0, self.length)
        return re.matches(in: self as String, options: [], range: checkRange).compactMap { $0.range }
    }
}

func roundToClosest(_ number: Double, to: Double) -> Int {
    return Int(to * round(number / to))
}

/* extension NSRange {
    // var utf16ViewRange: Range<String.UTF16View.Index> {
    // return String.UTF16View.Index(self.location)..<String.UTF16View.Index(self.location + self.length)
    // }
    func utf16ViewRange(in string: String) -> Range<String.UTF16View.Index> {
        return String.UTF16View.Index(utf16Offset: self.location, in: string)..<String.UTF16View.Index(utf16Offset: self.location + self.length, in: string)
    }
    
    func utf8ViewRange(in string: String) -> Range<String.UTF16View.Index> {
        return String.UTF8View.Index(utf16Offset: self.location, in: string)..<String.UTF8View.Index(utf16Offset: self.location + self.length, in: string)
    }
} */
