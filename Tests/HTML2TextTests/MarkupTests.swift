//
//  MarkupTests.swift
//  
//
//  Created by Greg Pierce on 6/7/24.
//

import XCTest
@testable import HTML2Text

final class MarkupTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testList() throws {
        let html = """
<html>
<body>

<ul>
<li>List</li>
<li>List</li>
</ul>

</body>
</html>
"""
        let h = HTML2Text(baseurl: "")
        let result = h.main(data: html)
        XCTAssert(result == "- List\n- List\n")
    }
    
    func testLink() throws {
        let html = """
<html>
<body>

<a href="https://github.com">GitHub</a>

</body>
</html>
"""
        let h = HTML2Text(baseurl: "")
        h.inline_links = true
        let result = h.main(data: html)
        XCTAssert(result == "[GitHub](https://github.com)\n")
    }
    
    func testListLink() throws {
        let html = """
<html>
<body>

<ul>
<li><a href="link1">1</a></li>
<li><a href="link2">2</a></li>
</ul>

</body>
</html>
"""
        let h = HTML2Text(baseurl: "")
        h.inline_links = true
        let result = h.main(data: html)
        XCTAssert(result == "- [1](link1)\n- [2](link2)\n")
    }
    
    func testListBoldLink() throws {
        let html = """
<html>
<body>

<ul>
<li><a href="link1"><b>1</b></a></li>
<li><a href="link2"><b>2</b></a></li>
</ul>

</body>
</html>
"""
        let h = HTML2Text(baseurl: "")
        h.inline_links = true
        let result = h.main(data: html)
        XCTAssert(result == "- [**1**](link1)\n- [**2**](link2)\n")
    }
    
    func testEmLink() throws {
        let html = """
<a href="t1"><em>1</em></a>
<a href="t2"><em>2</em></a>
"""
        let h = HTML2Text(baseurl: "")
        h.inline_links = true
        let result = h.main(data: html)
        XCTAssert(result == "[_1_](t1) [_2_](t2)\n")
    }

    func testLinkEm() throws {
        let html = """
<em><a href="t1">1</a></em>
<em><a href="t2">2</a></em>
"""
        let h = HTML2Text(baseurl: "")
        h.inline_links = true
        let result = h.main(data: html)
        XCTAssert(result == "_[1](t1)_ _[2](t2)_\n")
    }
    
    func testHeading() throws {
        let html = """
<h2><a href="a1">H1</a></h2>
<h2><a href="a2">H2</a></h2>
"""
        let h = HTML2Text(baseurl: "")
        h.inline_links = true
        let result = h.main(data: html)
        XCTAssert(result == "## [H1](a1)\n\n## [H2](a2)\n")
    }
    
    func testEmptyStartAttr() throws {
        let html = """
<ol start="">
<li>First</li>
<li>Second</li>
</ol>
"""
        let h = HTML2Text(baseurl: "")
        h.inline_links = true
        let result = h.main(data: html)
        XCTAssert(result == "1. First\n2. Second\n")
    }
    
    func testValidStartAttr() throws {
        let html = """
<ol start="5">
<li>First</li>
<li>Second</li>
</ol>
"""
        let h = HTML2Text(baseurl: "")
        h.inline_links = true
        let result = h.main(data: html)
        XCTAssert(result == "5. First\n6. Second\n")
    }

}
