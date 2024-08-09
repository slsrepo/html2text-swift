//
//  html2text.swift
//  html2text
//
//  Created by Shahaf Levi on 10/09/2020.
//  Copyright © 2020 Sl's Repository Ltd. All rights reserved.
//

import Foundation
import SwiftSoup

/* #!/usr/local/bin/python
 // -*- coding: utf-8
 from __future__ import unicode_literals

 /* html2text: Turn HTML into equivalent Markdown-structured text. */
 __version__ = "3.200.3"
 __author__ = "Aaron Swartz (me@aaronsw.com)"
 __copyright__ = "(C) 2004-2008 Aaron Swartz. GNU GPL 3."
 __contributors__ = ["Martin 'Joey' Schulze", "Ricardo Reyes", "Kevin Jay North"]
 // Brett's fixes
 // Output MMD definition lists
 // Output lists that start left and indent by 4 spaces
 // Rudimentary table conversion
 // Handler for emphasis and code incorrectly formatting in links (**[text**][])

 // TODO:
 //   Support decoded entities with unifiable. */
public class HTML2Text: NodeVisitor {
    public func has_key(_ x: [String: String], _ y: String) -> Bool {
        if x.has_key(y) {
            return x.has_key(y)
        } else {
            return x.values.contains(y)
        }
    }

//
//    try:
//    import htmlentitydefs
//    import urlparse
//    import HTMLParser
//    except ImportError: // Python3
//    import html.entities as htmlentitydefs
//    import urllib.parse as urlparse
//    import html.parser as HTMLParser
//    try: // Python3
//    import urllib.request as urllib
//    except:
//    import urllib
//    import optparse, re, sys, codecs, types
//
//    try: from textwrap import wrap
//    except: pass

    // Use Unicode characters instead of their ascii psuedo-replacements
    public let UNICODE_SNOB = true

    // Escape all special characters.  Output is less readable, but avoids corner case formatting issues.
    public let ESCAPE_SNOB = false

    // Put the links after each paragraph instead of at the end.
    public let LINKS_EACH_PARAGRAPH = true

    // Wrap long lines at position. 0 for no wrapping. (Requires Python 2.3.)
    public let BODY_WIDTH = 0

    // Don't show internal links (href="#local-anchor") -- corresponding link targets
    // won't be visible in the plain text file anyway.
    public let SKIP_INTERNAL_LINKS = true // true

    // Use inline, rather than reference, formatting for images and links
    public let INLINE_LINKS = false

    // Number of pixels Google indents nested lists
    public let GOOGLE_LIST_INDENT = 36

    public let IGNORE_ANCHORS = false
    public let IGNORE_IMAGES = false
    public let IGNORE_EMPHASIS = false

    /* Entity Nonsense */
    // let htmlentitydefs = ["AElig": "Æ", "Aacute": "Á", "Acirc": "Â", "Agrave": "À", "Alpha": "Α", "Aring": "Å", "Atilde": "Ã", "Auml": "Ä", "Beta": "Β", "Ccedil": "Ç", "Chi": "Χ", "Dagger": "‡", "Delta": "Δ", "ETH": "Ð", "Eacute": "É", "Ecirc": "Ê", "Egrave": "È", "Epsilon": "Ε", "Eta": "Η", "Euml": "Ë", "Gamma": "Γ", "Iacute": "Í", "Icirc": "Î", "Igrave": "Ì", "Iota": "Ι", "Iuml": "Ï", "Kappa": "Κ", "Lambda": "Λ", "Mu": "Μ", "Ntilde": "Ñ", "Nu": "Ν", "OElig": "Œ", "Oacute": "Ó", "Ocirc": "Ô", "Ograve": "Ò", "Omega": "Ω", "Omicron": "Ο", "Oslash": "Ø", "Otilde": "Õ", "Ouml": "Ö", "Phi": "Φ", "Pi": "Π", "Prime": "″", "Psi": "Ψ", "Rho": "Ρ", "Scaron": "Š", "Sigma": "Σ", "THORN": "Þ", "Tau": "Τ", "Theta": "Θ", "Uacute": "Ú", "Ucirc": "Û", "Ugrave": "Ù", "Upsilon": "Υ", "Uuml": "Ü", "Xi": "Ξ", "Yacute": "Ý", "Yuml": "Ÿ", "Zeta": "Ζ", "aacute": "á", "acirc": "â", "acute": "´", "aelig": "æ", "agrave": "à", "alefsym": "ℵ", "alpha": "α", "amp": "&", "and": "∧", "ang": "∠", "aring": "å", "asymp": "≈", "atilde": "ã", "auml": "ä", "bdquo": "„", "beta": "β", "brvbar": "¦", "bull": "•", "cap": "∩", "ccedil": "ç", "cedil": "¸", "cent": "¢", "chi": "χ", "circ": "ˆ", "clubs": "♣", "cong": "≅", "copy": "©", "crarr": "↵", "cup": "∪", "curren": "¤", "dArr": "⇓", "dagger": "†", "darr": "↓", "deg": "°", "delta": "δ", "diams": "♦", "divide": "÷", "eacute": "é", "ecirc": "ê", "egrave": "è", "empty": "∅", "emsp": "u{2003}", "ensp": "u{2002}", "epsilon": "ε", "equiv": "≡", "eta": "η", "eth": "ð", "euml": "ë", "euro": "€", "exist": "∃", "fnof": "ƒ", "forall": "∀", "frac12": "½", "frac14": "¼", "frac34": "¾", "frasl": "⁄", "gamma": "γ", "ge": "≥", "gt": ">", "hArr": "⇔", "harr": "↔", "hearts": "♥", "hellip": "…", "iacute": "í", "icirc": "î", "iexcl": "¡", "igrave": "ì", "image": "ℑ", "infin": "∞", "int": "∫", "iota": "ι", "iquest": "¿", "isin": "∈", "iuml": "ï", "kappa": "κ", "lArr": "⇐", "lambda": "λ", "lang": "〈", "laquo": "«", "larr": "←", "lceil": "⌈", "ldquo": "“", "le": "≤", "lfloor": "⌊", "lowast": "∗", "loz": "◊", "lrm": "u{200e}", "lsaquo": "‹", "lsquo": "‘", "lt": "<", "macr": "¯", "mdash": "—", "micro": "µ", "middot": "·", "minus": "−", "mu": "μ", "nabla": "∇", "nbsp": "\xa0", "ndash": "–", "ne": "≠", "ni": "∋", "not": "¬", "notin": "∉", "nsub": "⊄", "ntilde": "ñ", "nu": "ν", "oacute": "ó", "ocirc": "ô", "oelig": "œ", "ograve": "ò", "oline": "‾", "omega": "ω", "omicron": "ο", "oplus": "⊕", "or": "∨", "ordf": "ª", "ordm": "º", "oslash": "ø", "otilde": "õ", "otimes": "⊗", "ouml": "ö", "para": "¶", "part": "∂", "permil": "‰", "perp": "⊥", "phi": "φ", "pi": "π", "piv": "ϖ", "plusmn": "±", "pound": "£", "prime": "′", "prod": "∏", "prop": "∝", "psi": "ψ", "quot": "\"", "rArr": "⇒", "radic": "√", "rang": "〉", "raquo": "»", "rarr": "→", "rceil": "⌉", "rdquo": "”", "real": "ℜ", "reg": "®", "rfloor": "⌋", "rho": "ρ", "rlm": "u{200f}", "rsaquo": "›", "rsquo": "’", "sbquo": "‚", "scaron": "š", "sdot": "⋅", "sect": "§", "shy": "\xad", "sigma": "σ", "sigmaf": "ς", "sim": "∼", "spades": "♠", "sub": "⊂", "sube": "⊆", "sum": "∑", "sup": "⊃", "sup1": "¹", "sup2": "²", "sup3": "³", "supe": "⊇", "szlig": "ß", "tau": "τ", "there4": "∴", "theta": "θ", "thetasym": "ϑ", "thinsp": "u{2009}", "thorn": "þ", "tilde": "˜", "times": "×", "trade": "™", "uArr": "⇑", "uacute": "ú", "uarr": "↑", "ucirc": "û", "ugrave": "ù", "uml": "¨", "upsih": "ϒ", "upsilon": "υ", "uuml": "ü", "weierp": "℘", "xi": "ξ", "yacute": "ý", "yen": "¥", "yuml": "ÿ", "zeta": "ζ", "zwj": "u{200d}", "zwnj": "u{200c}"]
    public let name2codepoint = ["AElig": 198, "Aacute": 193, "Acirc": 194, "Agrave": 192, "Alpha": 913, "Aring": 197, "Atilde": 195, "Auml": 196, "Beta": 914, "Ccedil": 199, "Chi": 935, "Dagger": 8225, "Delta": 916, "ETH": 208, "Eacute": 201, "Ecirc": 202, "Egrave": 200, "Epsilon": 917, "Eta": 919, "Euml": 203, "Gamma": 915, "Iacute": 205, "Icirc": 206, "Igrave": 204, "Iota": 921, "Iuml": 207, "Kappa": 922, "Lambda": 923, "Mu": 924, "Ntilde": 209, "Nu": 925, "OElig": 338, "Oacute": 211, "Ocirc": 212, "Ograve": 210, "Omega": 937, "Omicron": 927, "Oslash": 216, "Otilde": 213, "Ouml": 214, "Phi": 934, "Pi": 928, "Prime": 8243, "Psi": 936, "Rho": 929, "Scaron": 352, "Sigma": 931, "THORN": 222, "Tau": 932, "Theta": 920, "Uacute": 218, "Ucirc": 219, "Ugrave": 217, "Upsilon": 933, "Uuml": 220, "Xi": 926, "Yacute": 221, "Yuml": 376, "Zeta": 918, "aacute": 225, "acirc": 226, "acute": 180, "aelig": 230, "agrave": 224, "alefsym": 8501, "alpha": 945, "amp": 38, "and": 8743, "ang": 8736, "aring": 229, "asymp": 8776, "atilde": 227, "auml": 228, "bdquo": 8222, "beta": 946, "brvbar": 166, "bull": 8226, "cap": 8745, "ccedil": 231, "cedil": 184, "cent": 162, "chi": 967, "circ": 710, "clubs": 9827, "cong": 8773, "copy": 169, "crarr": 8629, "cup": 8746, "curren": 164, "dArr": 8659, "dagger": 8224, "darr": 8595, "deg": 176, "delta": 948, "diams": 9830, "divide": 247, "eacute": 233, "ecirc": 234, "egrave": 232, "empty": 8709, "emsp": 8195, "ensp": 8194, "epsilon": 949, "equiv": 8801, "eta": 951, "eth": 240, "euml": 235, "euro": 8364, "exist": 8707, "fnof": 402, "forall": 8704, "frac12": 189, "frac14": 188, "frac34": 190, "frasl": 8260, "gamma": 947, "ge": 8805, "gt": 62, "hArr": 8660, "harr": 8596, "hearts": 9829, "hellip": 8230, "iacute": 237, "icirc": 238, "iexcl": 161, "igrave": 236, "image": 8465, "infin": 8734, "int": 8747, "iota": 953, "iquest": 191, "isin": 8712, "iuml": 239, "kappa": 954, "lArr": 8656, "lambda": 955, "lang": 9001, "laquo": 171, "larr": 8592, "lceil": 8968, "ldquo": 8220, "le": 8804, "lfloor": 8970, "lowast": 8727, "loz": 9674, "lrm": 8206, "lsaquo": 8249, "lsquo": 8216, "lt": 60, "macr": 175, "mdash": 8212, "micro": 181, "middot": 183, "minus": 8722, "mu": 956, "nabla": 8711, "nbsp": 160, "ndash": 8211, "ne": 8800, "ni": 8715, "not": 172, "notin": 8713, "nsub": 8836, "ntilde": 241, "nu": 957, "oacute": 243, "ocirc": 244, "oelig": 339, "ograve": 242, "oline": 8254, "omega": 969, "omicron": 959, "oplus": 8853, "or": 8744, "ordf": 170, "ordm": 186, "oslash": 248, "otilde": 245, "otimes": 8855, "ouml": 246, "para": 182, "part": 8706, "permil": 8240, "perp": 8869, "phi": 966, "pi": 960, "piv": 982, "plusmn": 177, "pound": 163, "prime": 8242, "prod": 8719, "prop": 8733, "psi": 968, "quot": 34, "rArr": 8658, "radic": 8730, "rang": 9002, "raquo": 187, "rarr": 8594, "rceil": 8969, "rdquo": 8221, "real": 8476, "reg": 174, "rfloor": 8971, "rho": 961, "rlm": 8207, "rsaquo": 8250, "rsquo": 8217, "sbquo": 8218, "scaron": 353, "sdot": 8901, "sect": 167, "shy": 173, "sigma": 963, "sigmaf": 962, "sim": 8764, "spades": 9824, "sub": 8834, "sube": 8838, "sum": 8721, "sup": 8835, "sup1": 185, "sup2": 178, "sup3": 179, "supe": 8839, "szlig": 223, "tau": 964, "there4": 8756, "theta": 952, "thetasym": 977, "thinsp": 8201, "thorn": 254, "tilde": 732, "times": 215, "trade": 8482, "uArr": 8657, "uacute": 250, "uarr": 8593, "ucirc": 251, "ugrave": 249, "uml": 168, "upsih": 978, "upsilon": 965, "uuml": 252, "weierp": 8472, "xi": 958, "yacute": 253, "yen": 165, "yuml": 255, "zeta": 950, "zwj": 8205, "zwnj": 8204]
    public func name2cp(_ k: String) -> Int? {
        if k == "apos" {
            return ord("'")
        }

        // if hasattr(htmlentitydefs, "name2codepoint") { // requires Python 2.3
        return name2codepoint[k]
        /* } else {
         k = htmlentitydefs.entitydefs[k]
         if k.startswith("&#") && k.endswith(";") { return Int(k[2...-1]) } // not in latin-1
         return ord(codecs.latin_1_decode(k)[0])
         } */
    }

    public var unifiable = ["rsquo": "'", "lsquo": "'", "rdquo": "\"", "ldquo": "\"",
                            "copy": "(C)", "mdash": "--", "nbsp": " ", "rarr": "->", "larr": "<-", "middot": "*",
                            "ndash": "-", "oelig": "oe", "aelig": "ae",
                            "agrave": "a", "aacute": "a", "acirc": "a", "atilde": "a", "auml": "a", "aring": "a",
                            "egrave": "e", "eacute": "e", "ecirc": "e", "euml": "e",
                            "igrave": "i", "iacute": "i", "icirc": "i", "iuml": "i",
                            "ograve": "o", "oacute": "o", "ocirc": "o", "otilde": "o", "ouml": "o",
                            "ugrave": "u", "uacute": "u", "ucirc": "u", "uuml": "u",
                            "lrm": "", "rlm": ""]

    public var unifiable_n: [Int: String] = [8217: "'", 8216: "'", 8221: "\"", 8220: "\"", 169: "(C)", 8212: "--", 8594: "->", 8592: "<-", 183: "*", 8211: "-", 339: "oe", 230: "ae", 224: "a", 225: "a", 226: "a", 227: "a", 228: "a", 229: "a", 232: "e", 233: "e", 234: "e", 235: "e", 236: "i", 237: "i", 238: "i", 239: "i", 242: "o", 243: "o", 244: "o", 245: "o", 246: "o", 249: "u", 250: "u", 251: "u", 252: "u", 8206: "", 8207: ""]
    /* {
     var _unifiable_n: [Int: String] = [:]

     for k: String in unifiable.keys {
     _unifiable_n[name2cp(k)!] = unifiable[k]
     }

     return _unifiable_n
     } */

    /* End Entity Nonsense */

    /// Return true if the line does only consist of whitespace characters.
    public func onlywhite(_ line: String) -> Bool {
        for c in line {
            if c != Character(" "), c != Character("  ") {
                return c == Character(" ")
            }
        }

        // return line
        return false
    }

    public func hn(_ tag: String) -> Int {
        if tag.first == "h", tag.count == 2 {
            if let n = Int(tag.substring(startingAt: 1)), (1 ... 10).contains(n) {
                return n
            }
        } else {
            return 0
        }
        return 0
    }

    /// returns a hash of css attributes
    public func dumb_property_dict(_ style: String) -> [String: String] {
        var zdict: [String: String] = [:]
        var zarr: [[String]] = []
        for z: String in style.split(";") {
            if z.contains(":") {
                zarr.append(z.split(separator: ":", maxSplits: 1).map { sub -> String in
                    String(sub)
                })
            }
        }

        for xarr in zarr {
            let x = xarr[0]
            let y = xarr[1]

            zdict[x.strip()] = y.strip()
        }

        return zdict
    }

    /// returns a hash of css selectors, each of which contains a hash of css attributes
    public func dumb_css_parser(_ data: String) -> [String: [String: String]] {
        // remove @import sentences
        var data = data

        data += ";"

        /* var importIndex = data.find("@import")

         while importIndex != -1 {
         data = data[data.startIndex...String.Index(importIndex, within: data.utf8)] + data[data.find(";", importIndex) + 1...]
         importIndex = data.find("@import")
         } */

        // parse the css. reverted from dictionary compehension in order to support older pythons

        var elementsarr: [[String]] = []
        for x in data.split("}") {
            if x.strip().contains("{") {
                elementsarr.append(x.split("{"))
            }
        }

        var elements: [String: [String: String]] = [:]

        for aarr in elementsarr {
            let a = aarr[0]
            let b = aarr[1]

            elements[a.strip()] = dumb_property_dict(b)
        }

        return elements
    }

    /// returns a hash of the "final" style attributes of the element
    public func element_style(_ attrs: [String: String], _ style_def: [String: String], _ parent_style: [String: String]) -> [String: String] {
        var style = parent_style

        if attrs.keys.contains("class") {
            for css_class in attrs["class"]!.split() {
                if let css_style = style_def["." + css_class] {
                    style.updateValue(css_style, forKey: css_class)
                }
            }
        }

        if attrs.keys.contains("style") {
            let immediate_style = dumb_property_dict(attrs["style"]!).first!
            // style.update(immediate_style, forKey: "style")
            style.updateValue(immediate_style.value, forKey: immediate_style.key)
        }

        return style
    }

    /// finds out whether this is an ordered or unordered list
    public func google_list_style(_ style: [String: String]) -> String {
        if style.keys.contains("list-style-type") {
            let list_style = style["list-style-type"]

            if ["disc", "circle", "square", "none"].contains(list_style) {
                return "ul"
            }
        }

        return "ol"
    }

    /// check if the style of the element has the "height" attribute explicitly defined
    public func google_has_height(_ style: [String: String]) -> Bool {
        if style.keys.contains("height") {
            return true
        }

        return false
    }

    /// return a list of all emphasis modifiers of the element
    public func google_text_emphasis(_ style: [String: String]) -> [String] {
        var emphasis: [String] = []

        if style.keys.contains("text-decoration") {
            emphasis.append(style["text-decoration"]!)
        }

        if style.keys.contains("font-style") {
            emphasis.append(style["font-style"]!)
        }

        if style.keys.contains("font-weight") {
            emphasis.append(style["font-weight"]!)
        }

        return emphasis
    }

    /// check if the css of the current element defines a fixed width font
    public func google_fixed_width_font(_ style: [String: String]) -> Bool {
        var font_family: String? = ""

        if style.keys.contains("font-family") {
            font_family = style["font-family"]
        }

        if font_family == "Courier New" || font_family == "Consolas" {
            return true
        }

        return false
    }

    /// extract numbering from list element attributes
    public func list_numbering_start(_ attrs: [String: String]) -> Int {
        if attrs.keys.contains("start"), let s = attrs["start"], let ix = Int(s) {
            return ix - 1
        } else {
            return 0
        }
    }

    // }

    // public class HTML2Text {
    // Config options

    /// Use Unicode characters instead of their ascii psuedo-replacements
    // /// Escape all special characters.  Output is less readable, but avoids corner case formatting issues.
    public var unicode_snob: Bool = true

    /// Escape all special characters.  Output is less readable, but avoids corner case formatting issues.
    public var escape_snob: Bool = false

    /// Put the links after each paragraph instead of at the end.
    public var links_each_paragraph: Bool = false

    // /// Wrap long lines at position. 0 for no wrapping. (Requires Python 2.3.)
    /// Number of characters per output line, 0 for no wrapping/no limitation.
    public var body_width: Int = 0

    /// Don't show internal links (href="#local-anchor") -- corresponding link targets won't be visible in the plain text file anyway.
    public var skip_internal_links: Bool = false // true

    /// Use inline, rather than reference, formatting for images and links
    public var inline_links: Bool = false

    /// Number of pixels Google indents nested lists
    public var google_list_indent: Int = 36

    /// Don't include any formatting for links
    public var ignore_links: Bool = false

    /// Don't include any formatting for images
    public var ignore_images: Bool = false

    /// Don't include any formatting for emphasis
    public var ignore_emphasis: Bool = false

    /// Hide strike-through text. only relevant when google_doc is specified as well"
    public var hide_strikethrough: Bool = true

    /// Convert an html-exported Google Document
    public var google_doc = true

    public var ul_item_mark = "*"
    public var emphasis_mark = "_"
    public var strong_mark = "**"

    public var out: String?
    public var outtextlist: [String] = [] // empty list to store output characters before they are "joined"

    public var quiet = false
    public var p_p = 0 // number of newline character to print before next output
    public var outcount = 0
    public var start = true
    public var space = false
    public var a: [[String: String]] = []
    public var astack: [[String: String]] = []
    public var maybe_automatic_link: String?
    public var maybe_linked_image = false
    public var absolute_url_matcher = #"^[a-zA-Z+]+://"#
    public var acount = 0
    public var list: [[String: String]] = []
    public var blockquote = 0
    public var supid: String?
    public var suplist: [[String: String]] = []
    public var supdeflist: [[String: String]] = []
    public var pre = false
    public var startpre = false
    public var code = false
    public var br_toggle = ""
    public var lastWasNL = false
    public var lastWasList = false
    public var style = false
    public var style_def: [String: String] = [:]
    public var tag_stack: [(tag: String, attrs: [String: String], style: [String: String])] = []
    public var emphasis = false
    public var drop_white_space = false
    public var inheader = false
    public var headerid = ""
    public var abbr_title: String? // current abbreviation definition
    public var abbr_data: String? // last inner HTML (for abbr being defined)
    public var abbr_list: [String: String] = [:] // stack of abbreviations to write later
    public var table = 0
    public var table_cols = 0
    public var table_cols_max = 0
    public var table_has_header = false
    public var baseurl = ""

    public var data = ""
    public var document: Document?
    public var outtext = ""

    public init(_ out: String? = nil, baseurl: String = "") {
        // Config options
        unicode_snob = UNICODE_SNOB
        escape_snob = ESCAPE_SNOB
        links_each_paragraph = LINKS_EACH_PARAGRAPH
        body_width = BODY_WIDTH
        skip_internal_links = SKIP_INTERNAL_LINKS
        inline_links = INLINE_LINKS
        google_list_indent = GOOGLE_LIST_INDENT
        ignore_links = IGNORE_ANCHORS
        ignore_images = IGNORE_IMAGES
        ignore_emphasis = IGNORE_EMPHASIS
        google_doc = true
        ul_item_mark = "-"
        emphasis_mark = "_"
        strong_mark = "**"

        self.out = out

        outtextlist = [] // empty list to store output characters before they are "joined"

        quiet = false
        p_p = 0 // number of newline character to print before next output
        outcount = 0
        start = true
        space = false
        a = []
        astack = []
        maybe_automatic_link = nil
        maybe_linked_image = false
        absolute_url_matcher = #"^[a-zA-Z+]+://"#
        acount = 0
        list = []
        blockquote = 0
        pre = false
        startpre = false
        code = false
        br_toggle = ""
        lastWasNL = false
        lastWasList = false
        style = false
        style_def = [:]
        tag_stack = []
        emphasis = false
        drop_white_space = false
        inheader = false
        headerid = ""
        abbr_title = nil // current abbreviation definition
        abbr_data = nil // last inner HTML (for abbr being defined)
        abbr_list = [:] // stack of abbreviations to write later
        table = 0
        table_cols = 0
        table_cols_max = 0
        table_has_header = false
        self.baseurl = baseurl
        data = ""

        // unifiable_n.removeValue(name2cp("nbsp"))
        unifiable["nbsp"] = "&nbsp_place_holder;"
    }

    /// Feed some text to the parser. It is processed insofar as it consists of complete elements; incomplete data is buffered until more data is fed or close() is called.
    public func feed(_ data: String) {
        self.data += data.replace("</' + 'script>", "</ignore>")
        if baseurl != "" {
            document = try! SwiftSoup.parse(data, baseurl)
        } else {
            document = try! SwiftSoup.parse(data)
        }

        try! document?.traverse(self)
    }

    public func head(_ node: Node, _: Int) throws {
        handle_tag(node.nodeName(),
                   dict(uniqueKeysWithValues: node.getAttributes()!.asList().flatMap { (attr: Attribute) -> [String: String] in
                       [attr.getKey(): attr.getValue()]
                   }), true)
    }

    public func tail(_ node: Node, _: Int) throws {
        handle_tag(node.nodeName(), nil, false)
    }

    public func handle(_ data: String) -> String {
        feed(data)
        feed("")

        return optwrap(close())
    }

    public func outtextf(_ s: String) {
        outtextlist.append(s)

        if s != "" {
            lastWasNL = s.last == "\n"
        }
    }

    /// Force processing of all buffered data as if it were followed by an end-of-file mark.
    public func close() -> String {
        // HTMLParser.HTMLParser.close(self)

        pbr()
        o("", false, "end")
        // self.o(data, false, "end")

        outtext = outtext.join(outtextlist)
        var nbsp: String
        if unicode_snob {
            nbsp = chr(name2cp("nbsp")!)
        } else {
            nbsp = " "
        }

        outtext = outtext.replacingOccurrences(of: #"(\[\^(.*?)\]\: (.*?)) ↩"#, with: "$1", options: .regularExpression) // Remove ↩ from footnote definitions
        outtext = outtext.replace("&nbsp_place_holder;", nbsp)

        return outtext
    }

    /// This method is called to process decimal and hexadecimal numeric character references of the form &#NNN; and &#xNNN;. For example, the decimal equivalent for &gt; is &#62;, whereas the hexadecimal is &#x3E;; in this case the method will receive '62' or 'x3E'.
    public func handle_charref(_ c: String) {
        o(charref(c), true)
    }

    /// This method is called to process a named character reference of the form &name; (e.g. &gt;), where name is a general entity reference (e.g. 'gt')
    public func handle_entityref(_ c: String) {
        o(entityref(c), true)
    }

    /// This method is called to handle the start of a tag (e.g. <div id="main">).
    public func handle_starttag(_ tag: String, _ attrs: [String: String]) {
        handle_tag(tag, attrs, true)
    }

    /// This method is called to handle the end tag of an element (e.g. </div>).
    public func handle_endtag(_ tag: String) {
        handle_tag(tag, nil, false)
    }

    /// returns the index of certain set of attributes (of a link) in the self.a list.
    /// If the set of attributes is not found, returns nil
    public func previousIndex(_ attrs: [String: String]) -> Int? {
        if !has_key(attrs, "href") {
            return nil
        }

        var i = -1
        for a in a {
            i += 1
            var match = false

            if a.has_key("href"), a["href"]! == attrs["href"] {
                if has_key(a, "title") || has_key(attrs, "title") {
                    if has_key(a, "title"), has_key(attrs, "title"), a["title"] == attrs["title"] {
                        match = true
                    }
                } else {
                    match = true
                }
            }

            if match {
                return i
            }
        }
        return nil
    }

    public func drop_last(_ nLetters: Int) {
        if !quiet, nLetters < outtext.count {
            outtext = outtext.substring(endingAt: outtext.count - nLetters) // [...(-nLetters)]
        }
    }

    /// handles various text emphases
    public func handle_emphasis(_ start: Bool, _ tag_style: [String: String], _ parent_style: [String: String]) {
        let tag_emphasis = google_text_emphasis(tag_style)
        let parent_emphasis = google_text_emphasis(parent_style)

        // handle Google's text emphasis
        let strikethrough = tag_emphasis.contains("line-through") && hide_strikethrough
        let bold = tag_emphasis.contains("bold") && !parent_emphasis.contains("bold")
        let italic = tag_emphasis.contains("italic") && !parent_emphasis.contains("italic")
        let fixed = google_fixed_width_font(tag_style) && !google_fixed_width_font(parent_style) && !pre

        if start {
            // crossed-out text must be handled before other attributes
            // in order not to output qualifiers unnecessarily
            if bold || italic || fixed {
                emphasis = true
            }

            if strikethrough {
                quiet = true
            }

            if italic {
                o(emphasis_mark)
                drop_white_space = true
            }

            if bold {
                o(strong_mark)
                drop_white_space = true
            }

            if fixed {
                o("`")
                drop_white_space = true
                code = true
            }
        } else {
            if bold || italic || fixed {
                // there must not be whitespace before closing emphasis mark
                emphasis = false
                space = false
                outtext = outtext.rstrip()
            }

            if fixed {
                if drop_white_space {
                    // empty emphasis, drop it
                    drop_last(1)
                    drop_white_space = false
                } else {
                    o("`")
                }
                code = false
            }

            if bold {
                if drop_white_space {
                    // empty emphasis, drop it
                    drop_last(2)
                    drop_white_space = false
                } else {
                    o(strong_mark)
                }
            }

            if italic {
                if drop_white_space {
                    // empty emphasis, drop it
                    drop_last(1)
                    drop_white_space = false
                } else {
                    o(emphasis_mark)
                }
            }

            // space is only allowed after *all* emphasis marks
            if bold || italic, !emphasis {
                o(" ")
            }

            if strikethrough {
                quiet = false
            }
        }
    }

    public func handle_tag(_ tag: String, _ attrs: [String: String]? = [:], _ start: Bool) {
        // attrs = fixattrs(attrs)
        var attrs = attrs
        if attrs == nil {
            attrs = [:]
        }
        // var tag = tag.nodeName()

        var parent_style: [String: String] = [:]
        var tag_style: [String: String] = [:]

        if google_doc {
            // The attrs parameter is empty for a closing tag. In addition, we need the attributes of the parent nodes in order to get a complete style description for the current element. We assume that google docs export well formed html.
            if start {
                if tag_stack.count > 0 {
                    parent_style = tag_stack.last!.style
                }

                tag_style = element_style(attrs!, style_def, parent_style)
                tag_stack.append((tag, attrs!, tag_style))
            }
        } else {
            if tag_stack.count > 0 {
                let pop = tag_stack.pop()
                // attrs = self.tag_stack.pop()?.attrs
                // tag_style = self.tag_stack.pop()!.style
                attrs = pop?.attrs
                tag_style = pop!.style

                if tag_stack.count > 0 {
                    parent_style = tag_stack.last!.style
                }
            }
        }

        if tag == "#text" {
            if start, let text = attrs!["text"], text != "\n " {
                if let lastItem = outtextlist.last, lastItem.count > 1, lastItem.substring(endingAt: 2) == "[^", Int(text) != nil {
                    // Clean Footnote number
                    return
                }
                // self.o(text, true)
                handle_data(text)
            }
        }

        if hn(tag) > 0 {
            p()

            if start {
                inheader = true
                o(hn(tag) * "#" + " ")
                if attrs!.keys.contains("id") {
                    headerid = attrs!["id"]!
                }
            } else {
                //                          if self.headerid != "" {
                //                              self.outtextf("[" + self.headerid + "]")
                //                          }

                inheader = false
                headerid = ""
                return // prevent redundant emphasis marks on headers
            }
        }

        if ["p", "div"].contains(tag) {
            if google_doc {
                if start, google_has_height(tag_style) {
                    p()
                } else {
                    soft_br()
                }
            } else {
                p()
            }
        }

        if tag == "sup", start {
            if has_key(attrs!, "id") {
                let id = attrs!["id"] ?? ""
                // self.supid = id
                o("[^" + escape_md(id).replace("fnref:", "") + "]")
                // self.suplist.append(["id": id, "outcount": String(self.outcount)])
                // self.suplist.append(["id": id, "outcount": String(self.outtextlist.count - 1)])
            }
        }

        if tag == "br", start {
            o("__BR__\n")
        }

        if tag == "hr", start {
            p()
            o("* * *")
            p()
        }

        if ["head", "style", "script"].contains(tag) {
            if start {
                quiet = true
            } else {
                quiet = false
            }
        }

        if tag == "style" {
            if start {
                style = true
            } else {
                style = false
            }
        }

        if ["body"].contains(tag) {
            quiet = 0 // sites like 9rules.com never close <head>
        }

        if tag == "blockquote" {
            if start {
                p()
                o("> ", false, "1")
                self.start = true
                blockquote += 1
            } else {
                blockquote -= 1
                p()
            }
        }

        if ["em", "i", "u"].contains(tag), !ignore_emphasis {
            o(emphasis_mark)
        }

        if ["strong", "b"].contains(tag), !ignore_emphasis {
            o(strong_mark)
        }

        if ["del", "strike", "s"].contains(tag) {
            if start {
                o("<" + tag + ">")
            } else {
                o("</" + tag + ">")
            }
        }

        if google_doc {
            if !inheader {
                // handle some font attributes, but leave headers clean
                handle_emphasis(start, tag_style, parent_style)
            }
        }

        if ["code", "tt"].contains(tag), !pre {
            o("`") // TODO: `` `this` ``
        }

        if tag == "abbr" {
            if start {
                abbr_title = nil
                abbr_data = ""

                if has_key(attrs!, "title") {
                    abbr_title = attrs!["title"]
                }
            } else {
                if abbr_title != nil {
                    abbr_list[abbr_data!] = abbr_title
                    abbr_title = nil
                }

                abbr_data = ""
            }
        }

        if tag == "a", !ignore_links {
            if start {
                if has_key(attrs!, "href"), !(skip_internal_links && attrs!["href"]!.startswith("#")), attrs!["href"]!.substring(endingAt: 3) != "#fn" {
                    astack.append(attrs!)
                    maybe_automatic_link = attrs!["href"]
                    maybe_linked_image = true
                } else {
                    astack.append([:])
                }
            } else {
                maybe_automatic_link = nil
                maybe_linked_image = false
                if astack.count > 0 {
                    if var a = astack.pop() {
                        if maybe_automatic_link != nil {
                            maybe_automatic_link = nil
                        } else if a.count > 0 {
                            if inline_links {
                                o("](" + escape_md(a["href"]!) + ")")
                            } else {
                                let i = previousIndex(a)

                                if i != nil {
                                    a = self.a[i!]
                                } else {
                                    acount += 1

                                    a["count"] = String(acount)
                                    a["outcount"] = String(outcount)

                                    self.a.append(a)
                                }

                                o("][" + String(a["count"]!) + "]")
                            }
                        }
                    }
                }
            }
        }

        if tag == "img", start, !ignore_images {
            if maybe_linked_image {
                o("[")
                maybe_linked_image = false
            }
            if var attrs = attrs, has_key(attrs, "src") {
                attrs["href"] = attrs["src"]
                let alt = attrs.get("alt") ?? ""
                o("![" + escape_md(alt) + "]")

                if inline_links {
                    o("(" + escape_md(attrs["href"]!) + ")")
                } else {
                    if let i = previousIndex(attrs) {
                        attrs = a[i]
                    } else {
                        acount += 1
                        attrs["count"] = String(acount)
                        attrs["outcount"] = String(outcount)
                        a.append(attrs)
                    }
                    o("[" + String(attrs["count"]!) + "]")
                }
            }
        }

        if tag == "dl", start {
            p()
        }

        if tag == "dt", !start {
            pbr()
        }

        if tag == "dd", start {
            o(":")
        }

        if tag == "dd", !start {
            p()
        }

        if ["ol", "ul"].contains(tag) {
            // Google Docs create sub lists as top level lists
            if list.count < 0, !lastWasList {
                p()
            }

            if start {
                var list_style = ""

                if google_doc {
                    list_style = google_list_style(tag_style)
                } else {
                    list_style = tag
                }

                let numbering_start = list_numbering_start(attrs!)

                list.append(["name": list_style, "num": String(numbering_start)])
            } else {
                if list.count > 0 {
                    _ = list.pop()
                }

                lastWasList = true

                if list.count == 0 {
                    p()
                }
            }
        } else {
            lastWasList = false
        }

        if tag == "li" {
            pbr()

            var li: [String: String] = [:]

            var isFootnote = false

            if let attrs = attrs, let id = attrs["id"] {
                // li["id"] = id
                // li["outcount"] = String(self.outcount)
                // self.supdeflist.append(li)
                isFootnote = id.substring(endingAt: 2) == "fn"
            }

            if start {
                if list.count > 0 {
                    li = list.last!
                } else {
                    li = ["name": "ul", "num": ""]
                }

                var nest_count = 0

                if google_doc {
                    nest_count = google_nest_count(tag_style)
                } else {
                    nest_count = list.count
                }

                o("    " * (nest_count - 1)) // TODO: line up <ol><li>s > 9 correctly.

                if li["name"] == "ul" {
                    o(ul_item_mark + " ")
                } else if li["name"] == "ol" {
                    li["num"] = String(Int(li["num"]!)! + 1)
                    list[list.count - 1] = li
                    o(String(li["num"]!) + ". ")
                }

                if isFootnote {
                    supdeflist.append(["id": attrs!["id"]!, "outcount": String(outtextlist.count - 1)])
                    outtextlist[outtextlist.count - 1] = "[^\(attrs!["id"]!.substring(startingAt: 3))]: "
                }

                self.start = true
            }
        }

        // breaks on block elements (and lists) within tables
        // breaks on single row tables
        if tag == "table" {
            p()

            if !start {
                table = 0
                table_has_header = false
                table_cols = 0
                table_cols_max = 0
            }
        }

        if tag == "thead" {
            table_has_header = true
        }

        if tag == "tr" {
            if start {
                if table == 2, table_has_header == true {
                    o("\n" + ("| ---- " * table_cols_max) + " |\n| ")
                    table_has_header = false
                } else if table_has_header == false, table == 0 {
                    o("\n| ----- |\n| ")
                } else {
                    o("\n| ")
                }
            } else {
                o(" |" * (table_cols_max - table_cols))
                table_cols_max = table_cols
                table_cols = 0
            }
            table += 1
        }

        if ["td", "th"].contains(tag) {
            if start {
                table_cols += 1
            } else {
                o(" | ")
            }
        }

        if tag == "pre" {
            if start {
                startpre = true
                pre = true
            } else {
                pre = false
            }

            p()
        }
    }

    public func pbr() {
        if p_p == 0 {
            p_p = 1
        }
    }

    public func p() {
        p_p = 2
    }

    public func soft_br() {
        pbr()
        br_toggle = "__BR__"
    }

    public func o(_ data: String, _ puredata: Bool = false, _ force: String = "0") {
        var data = data

        if abbr_data != nil {
            abbr_data! += data
        }

        if !quiet {
            if google_doc {
                // prevent white space immediately after "begin emphasis" marks ("**" && "_")
                let lstripped_data = data.lstrip()
                if drop_white_space, !(pre || code) {
                    data = lstripped_data
                }

                if lstripped_data != "" {
                    drop_white_space = false
                }
            }

            if puredata, !pre {
                data = re.sub(#"\s+"#, " ", data)

                if data != "", data.startswith(" ") {
                    space = true
                    data = data.substring(startingAt: 1)
                }
            }

            if data == "", force == "0" {
                return
            }

            if startpre {
                // self.out(" :") // TODO: not output when already one there
                if !data.startswith("\n") { // <pre>stuff...
                    data = "\n" + data
                }
            }

            var bq = (">" * blockquote)

            if !((force == "end") && data != "" && data.startswith(">")), blockquote > 0 {
                bq += " "
            }

            if pre {
                if list.count < 1 {
                    bq += "    "
                }

                // else: list content is already partially indented
                for _ in xrange(list.count) {
                    bq += "    "
                }

                data = data.replace("\n", "\n" + bq)
            }

            if startpre {
                startpre = false
                if list.count > 0 {
                    data = data.lstrip("\n") // use existing initial indentation
                }
            }

            if start {
                space = false
                p_p = 0
                start = false
            }

            if force == "end" {
                // It's the end.
                p_p = 0
                outtextf("\n")
                space = false
            }

            if p_p > 0 {
                outtextf((br_toggle + "\n" + bq) * p_p)
                space = false
                br_toggle = ""
            }

            if space {
                if !lastWasNL {
                    outtextf(" ")
                }

                space = false
            }

            if a.count > 0, (p_p == 2 && links_each_paragraph) || force == "end" {
                outtextf("\n")
                if force == "end" {
                    outtextf("\n")
                }

                var newa: [[String: String]] = []

                for link: [String: String] in a {
                    if link["href"] == "" {
                        continue
                    }

                    if outcount > Int(link["outcount"]!)! {
                        var fulllink = link["href"]

                        if fulllink!.startswith("//") {
                            fulllink = "https:\(fulllink!)"
                        }

                        if fulllink!.startswith("/") {
                            fulllink = "\(baseurl)\(fulllink!)"
                        }
                        outtextf("[" + String(link["count"]!) + "]: " + URL(string: fulllink!.stringByAddingPercentEncodingForFormUrlencoded()!)!.absoluteString.removingPercentEncoding!)

                        if has_key(link, "title") {
                            outtextf(" \"" + link["title"]! + "\"")
                        }

                        outtextf("\n")
                    } else {
                        newa.append(link)
                    }
                }

                if a != newa {
                    outtextf("\n") // Don't need an extra line when nothing was done.
                }

                a = newa
            }

            if abbr_list.count > 0, force == "end" {
                for (abbr, definition) in abbr_list.items() {
                    outtextf("  *[" + abbr + "]: " + definition + "\n")
                }
            }

            p_p = 0
            outtextf(data)
            outcount += 1
        }
    }

    /// This method is called to process arbitrary data (e.g. text nodes and the content of <script>...</script> and <style>...</style>).
    public func handle_data(_ data: String) {
        var data = data

        if data.contains(#"\/script>"#) {
            quiet = false
        }

        if style {
            let cssdata = dumb_css_parser(data).first!
            style_def = cssdata.value // .updateValue(cssdata.value, forKey: cssdata.key)
        }

        if maybe_automatic_link != nil {
            let href = maybe_automatic_link
            if href == data, href!.matches(absolute_url_matcher) {
                o("<" + data + ">")
                return
            } else {
                o("[")
                maybe_automatic_link = nil
            }
        }

        if !code, !pre {
            data = escape_md_section(data, snob: escape_snob)
        }

        o(data, true)
    }

    public func charref(_ name: String) -> String {
        var c: Int
        if ["x", "X"].contains(name.substring(startingAt: 1)) {
            c = Int(name.substring(startingAt: 1), radix: 16)!
        } else {
            c = Int(name)!
        }

        if unifiable_n.keys.contains(c), !unicode_snob {
            return unifiable_n[c]!
        } else {
            return chr(c)
        }
    }

    public func entityref(_ c: String) -> String {
        if unifiable.keys.contains(c), !unicode_snob {
            return unifiable[c]!
            /* } else {
             do {
             name2cp(c)
             } catch {
             return "&" + c + ";"
             } */
        } else {
            return chr(name2cp(c)!)
        }
    }

    public func unescape(_ s: String) -> String {
        let r_unescape = #"&(#?[xX]?(?:[0-9a-fA-F]+|\w{1,8}));"#

        var replaceEntities: String {
            let se = re.search(r_unescape, s)

            let sg = se.group(1) ?? ""

            if sg.startswith("#") {
                return charref(sg.substring(startingAt: 1))
            } else {
                return entityref(sg)
            }
        }

        return re.sub(r_unescape, replaceEntities, s)
    }

    /// calculate the nesting count of google doc lists
    public func google_nest_count(_ style: [String: String]) -> Int {
        var nest_count = 0

        if style.keys.contains("margin-left") {
            nest_count = Int(style["margin-left"]!.substring(endingAt: style["margin-left"]!.count - 2))! / google_list_indent

            return nest_count
        }

        return nest_count
    }

    /// Wrap all paragraphs in the provided text.
    public func optwrap(_ text: String) -> String {
        if !(body_width > 0) {
            return text
        }

        var result = ""
        var newlines = 0

        for para in text.split("\n") {
            if para.count > 0 {
                if !skipwrap(para) {
                    result += para.wrap(body_width).joined(separator: "\n")

                    if para.endswith("  ") {
                        result += "  \n"
                        newlines = 1
                    } else {
                        result += "\n\n"
                        newlines = 2
                    }
                } else {
                    if !onlywhite(para) {
                        result += para + "\n"
                        newlines = 1
                    }
                }
            } else {
                if newlines < 2 {
                    result += "\n"
                    newlines += 1
                }
            }
        }
        return result
    }

    // }

    var ordered_list_matcher = #"\d+\.\s"#
    var unordered_list_matcher = #"[-\*\+]\s"#
    var md_chars_matcher = #"([\\\[\]\(\)])"#
    var md_chars_matcher_all = #"([`\*_{}\[\]\(\)#!])"#
    var md_dot_matcher = #"""
    (?m)
    ^             // start of line
    (\s*\d+)      // optional whitespace and a number
    (\.)          // dot
    (?=\s)        // lookahead assert whitespace
    """# // , re.MULTILINE | re.VERBOSE)
    var md_plus_matcher = #"""
    (?m)
    ^
    (\s*)
    (\+)
    (?=\s)
    """# // , flags=re.MULTILINE | re.VERBOSE)
    var md_dash_matcher = #"""
    ^
    (\s*)
    (-)
    (?=\s|\-)     // followed by whitespace (bullet list, or spaced out hr)
    // or another dash (header or hr)
    """# // , flags=re.MULTILINE | re.VERBOSE)
    var slash_chars = #"\`*_{}[]()#+-.!"#
    var md_backslash_matcher = """
    (\\)          // match one slash
    (?=[\(#"\`*_{}[]()#+-.!"#)])      // followed by a char that requires escaping
    """ // , flags = re.VERBOSE)

    public func skipwrap(_ para: String) -> Bool {
        // If the text begins with four spaces or one tab, it's a code block; don't wrap
        if para.substring(endingAt: 4) == "    " || para.startswith("\t") {
            return true
        }

        // If the text begins with only two "--", possibly preceded by whitespace, that's an emdash; so wrap.
        let stripped = para.lstrip()

        if stripped.substring(endingAt: 2) == "--" && stripped.count > 2 && stripped[2] != "-" {
            return false
        }

        // I'm not sure what this is for; I thought it was to detect lists, but there's a <br>-inside-<span> case in one of the tests that also depends upon it.
        if stripped.substring(endingAt: 1) == "-" || stripped.substring(endingAt: 1) == "*" {
            return true
        }

        // If the text begins with a single -, *, or +, followed by a space, or an integer, followed by a ., followed by a space (in either case optionally preceeded by whitespace), it's a list; don't wrap.
        if re.match(ordered_list_matcher, stripped).boolValue || re.match(unordered_list_matcher, stripped).boolValue {
            return true
        }

        return false
    }

    /* public func wrapwrite(_ text: String) {
     text = text.encode('utf-8')
     try: #Python3
     sys.stdout.buffer.write(text)
     except AttributeError:
     sys.stdout.write(text)
     } */

    public func html2text(_ html: String, _ baseurl: String = "") -> String {
        let h = HTML2Text(baseurl: baseurl)
        return h.handle(html)
    }

    public func unescape(_ s: String, _ unicode_snob: Bool = false) -> String {
        let h = HTML2Text()
        h.unicode_snob = unicode_snob

        return h.unescape(s)
    }

    /// Escapes markdown-sensitive characters within other markdown constructs.
    public func escape_md(_ text: String) -> String {
        return re.sub(md_chars_matcher, #"\\\1"#, text)
    }

    /// Escapes markdown-sensitive characters across whole document sections.
    public func escape_md_section(_ text: String, snob: Bool = false) -> String {
        var text = re.sub(md_backslash_matcher, #"\\\1"#, text)

        if snob {
            text = re.sub(md_chars_matcher_all, #"\\\1"#, text)
        }

        text = re.sub(md_dot_matcher, #"\1\\\2"#, text)
        text = re.sub(md_plus_matcher, #"\1\\\2"#, text)
        text = re.sub(md_dash_matcher, #"\1\\\2"#, text)

        return text
    }

    public func normalize_tables(_ input: String) -> String {
        let pattern = #"(?P<table>(?<=\n)(\|.*?\n)+)"#

        var fix_table: String {
            let match = re.search(pattern, input)

            // return normtable(match.group("table")) + "\n"
            return normtable(match.group(1) ?? "") + "\n"
        }

        return re.sub(pattern, fix_table, input)
    }

    public func fixheadlines(_ input: String) -> String {
        let pattern = #"(?:\[\n*)?(#+) \[?(.*?)\n+\]([\[\(].*?[\]\)])"#

        // $1 [$2]$3
        var fixheadline: String {
            let match = re.search(pattern, input)

            let group1 = match.group(1) ?? ""
            let group2 = match.group(2) ?? ""
            let group3 = match.group(3) ?? ""

            return group1 + " [" + group2 + "]" + group3
        }

        // single replacement
        let text = re.sub(pattern, fixheadline, input) // , re.S)

        return text
    }

    public func fixbrackets(_ input: String) -> String {
        let pattern = #"(\s*)(`|[\*_]+)\[([^\]]+\2\])"#
        
        var text = input
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        while let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, (text as NSString).length)) {
            let group1 = (text as NSString).substring(with: match.range(at: 1))
            let group2 = (text as NSString).substring(with: match.range(at: 2))
            let group3 = (text as NSString).substring(with: match.range(at: 3))
            var fixbracket = group1 + "[" + group2 + group3
            for i in 0...9 {
                fixbracket = fixbracket.replace("\\\(i)", "$\(i)")
            }
            text = (text as NSString).replacingCharacters(in: match.range(at: 0), with: fixbracket)
        }
        return text
    }

    /// Justify a string to length n according to type.
    public func just(_ string: String, _ type: String, _ n: Int) -> String {
        if type == "::" {
            return string.center(n)
        } else if type == "-:" {
            return string.rjust(n)
        } else if type == ":-" {
            return string.ljust(n)
        } else {
            return string
        }
    }

    /// Aligns the vertical bars in a text table.
    public func normtable(_ text: String) -> String {
        // Start by turning the text into a list of lines.
        var lines = text.splitlines()
        var rows = lines.count

        // Figure out the cell formatting.
        var formatline = ""
        var formatrow = 0

        // First, find the separator line.
        for i in 0 ... rows {
            if Set(lines[i]).isSubset(of: "|:.- ") {
                formatline = lines[i]
                formatrow = i
                break
            }
        }

        // Delete the separator line from the content.
        lines.remove(at: formatrow)

        // Determine how each column is to be justified.
        formatline = formatline.strip(" ")

        if formatline.first == "|" {
            formatline = formatline.substring(startingAt: 1)
        }

        if formatline.last == "|" {
            formatline = formatline.substring(endingAt: formatline.count - 1)
        }

        let fstrings = formatline.split("|")
        var justify: [String] = []

        for cell in fstrings {
            let ends = "\(cell.first!)\(cell.last!)"
            if ends == "::" {
                justify.append("::")
            } else if ends == "-:" {
                justify.append("-:")
            } else {
                justify.append(":-")
            }
        }

        // Assume the number of columns in the separator line is the number for the entire table.
        let columns = justify.count

        // Extract the content into a matrix.
        var content: [String] = []

        for line in lines {
            var line = line.strip(" ")

            if line.count > 0 {
                if line.last == "|" {
                    line = line.substring(startingAt: 1)
                }

                if line.last == "|" {
                    line = String(line[...line.endIndex])
                }
            }

            let cells = line.split("|")

            // Put exactly one space at each end as "bumpers."
            var linecontent: [String] = []
            for x in cells {
                linecontent.append(" " + x.strip() + " ")
            }

            content.append(contentsOf: linecontent)
        }

        // Append cells to rows that don't have enough.
        rows = content.count

        for i in 0 ... rows {
            while content[i].count < columns {
                content[i].append("")
            }
        }

        // Get the width of the content in each column. The minimum width will be 2, because that's the shortest length of a formatting string and because that matches an empty column with "bumper" spaces.
        var widths = Array(repeating: 2, count: columns + 1)
        for row in content {
            for i in 0 ... columns {
                widths[i] = max(row[i].count, widths[i])
            }
        }
        // Add whitespace to make all the columns the same width and
        var formatted: [String] = []

        for row in content {
            var rowarr: [String] = []

            for (t, n) in zip(justify, widths) {
                rowarr.append(just(row, t, n))
            }

            formatted.append(rowarr.joined(separator: "|" + "|") + "|")
        }

        // Recreate the format line with the appropriate column widths.
        var linesarr: [String] = []
        for (s, n) in zip(justify, widths) {
            linesarr.append("\(s.first!)\("-" * (n - 2))\(s.last!)")
        }

        formatline = linesarr.joined(separator: "|" + "|") + "|"

        // Insert the formatline back into the table.
        formatted.insert(formatline, at: formatrow)

        // Return the formatted table.

        return formatted.joined(separator: "\n")
    }

    public func main(baseurl: String = "", data: String = "", ignoreEmphasis: Bool = false, ignoreLinks: Bool = false, ignoreImages: Bool = false, googleDoc: Bool = false, dashUnorderedList: Bool = false, asteriskEmphasis: Bool = false, bodyWidth: Int = 0, listIndent: Int = 36, hideStrikethrough: Bool = false, escapeAll: Bool = false) -> String {
        // var baseurl = ""

        //        p = optparse.OptionParser("%prog [(filename|url) [encoding]]",
        //                                  version="%prog " + __version__)
        //        p.add_option("--ignore-emphasis", dest="ignore_emphasis", action="store_true",
        //                     default=IGNORE_EMPHASIS, help="don't include any formatting for emphasis")
        //        p.add_option("--ignore-links", dest="ignore_links", action="store_true",
        //                     default=IGNORE_ANCHORS, help="don't include any formatting for links")
        //        p.add_option("--ignore-images", dest="ignore_images", action="store_true",
        //                     default=IGNORE_IMAGES, help="don't include any formatting for images")
        //        p.add_option("-g", "--google-doc", action="store_true", dest="google_doc",
        //                     default=False, help="convert an html-exported Google Document")
        //        p.add_option("-d", "--dash-unordered-list", action="store_true", dest="ul_style_dash",
        //                     default=False, help="use a dash rather than a star for unordered list items")
        //        p.add_option("-e", "--asterisk-emphasis", action="store_true", dest="em_style_asterisk",
        //                     default=False, help="use an asterisk rather than an underscore for emphasized text")
        //        p.add_option("-b", "--body-width", dest="body_width", action="store", type="int",
        //                     default=BODY_WIDTH, help="number of characters per output line, 0 for no wrap")
        //        p.add_option("-i", "--google-list-indent", dest="list_indent", action="store", type="int",
        //                     default=GOOGLE_LIST_INDENT, help="number of pixels Google indents nested lists")
        //        p.add_option("-s", "--hide-strikethrough", action="store_true", dest="hide_strikethrough",
        //                     default=False, help="hide strike-through text. only relevant when -g is specified as well")
        //        p.add_option("--escape-all", action="store_true", dest="escape_snob",
        //                     default=False, help="Escape all special characters.  Output is less readable, but avoids corner case formatting issues.")
        //        (options, args) = p.parse_args()
        // var data = ""

        // process input
        // var encoding = "utf-8"
        /* if args.count > 0 {
         var file_ = args[0]

         if args.count == 2 {
         encoding = args[1]
         }

         if args.count > 2 {
         p.error("Too many arguments")
         }

         if file_.startswith("http://") || file_.startswith("https://") {
         baseurl = file_
         j = urllib.urlopen(baseurl)
         data = j.read()
         }
         } else {
         data = sys.stdin.read()
         } */

        // let h = HTML2Text(baseurl: baseurl)
        self.baseurl = baseurl
        let h = self

        // handle options
        //        if options.ul_style_dash {
        //            h.ul_item_mark = "-"
        //        }
        //
        //        if options.em_style_asterisk {
        //            h.emphasis_mark = "*"
        //            h.strong_mark = "__"
        //        }
        //
        //        h.body_width = options.body_width
        //        h.list_indent = options.list_indent
        //        h.ignore_emphasis = options.ignore_emphasis
        //        h.ignore_links = options.ignore_links
        //        h.ignore_images = options.ignore_images
        //        h.google_doc = options.google_doc
        //        h.hide_strikethrough = options.hide_strikethrough
        //        h.escape_snob = options.escape_snob
        if dashUnorderedList {
            h.ul_item_mark = "-"
        }

        if asteriskEmphasis {
            h.emphasis_mark = "*"
            h.strong_mark = "__"
        }

        h.body_width = bodyWidth
        h.google_list_indent = listIndent
        h.ignore_emphasis = ignoreEmphasis
        h.ignore_links = ignoreLinks
        h.ignore_images = ignoreImages
        h.google_doc = googleDoc
        h.hide_strikethrough = hideStrikethrough
        h.escape_snob = escapeAll

        // wrapwrite(fixheadlines(normalize_tables(h.handle(data.replace("u{201c}", "\"").replace("u{201d}", "\"").replace("u{2018}","'").replace("u{2019}","'")))))
        // return wrapwrite(fixheadlines(fixbrackets(h.handle(data.replace("u{201c}", "\"").replace("u{201d}", "\"").replace("u{2018}","'").replace("u{2019}","'")))))
        var input = data.replace("u{201c}", "\"").replace("u{201d}", "\"").replace("u{2018}", "'").replace("u{2019}", "'")
        input = input.replace("’", "'").replace("”", "\"").replace("“", "\"").replace("‘", "'").replace("–", "--").replace("—", "--")
        return fixheadlines(fixbrackets(h.handle(input)))
    }

    public static func process(html: String, baseurl: String?) -> String {
        let h = HTML2Text(baseurl: baseurl!)

        let html2textresult = h.main(baseurl: baseurl!, data: html)

        var result = html2textresult.replacingOccurrences(of: #"([\*\-\+] .*?)\n+(?=[\*\-\+] )"#, with: "$1\n", options: .regularExpression)
        result = result.replacingOccurrences(of: #"(?m)\n{2,}"#, with: "\n\n")
        result = result.replacingOccurrences(of: "__BR__", with: "  ")

        return result
    }
}
