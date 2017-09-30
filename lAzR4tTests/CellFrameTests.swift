//
//  lAzR4tTests.swift
//  lAzR4tTests
//
//  Created by Jakob Hain on 9/29/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import XCTest
@testable import lAzR4t

class CellFrameTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOverlap() {
        XCTAssert(CellFrame.overlap(
            CellFrame(left: 1, bottom: 2, right: 3, top: 4),
            CellFrame(left: 0, bottom: 1, right: 2, top: 3)
        ))
        XCTAssertFalse(CellFrame.overlap(
            CellFrame(left: 1, bottom: 2, right: 3, top: 4),
            CellFrame(left: 0, bottom: 1, right: 2, top: 2)
        )) //Are adjacent
        XCTAssertFalse(CellFrame.overlap(
            CellFrame(left: 1, bottom: 2, right: 3, top: 4),
            CellFrame(left: 0, bottom: 1, right: 1, top: 3)
            )) //Are adjacent
        XCTAssert(CellFrame.overlap(
            CellFrame(left: 1, bottom: 2, right: 3, top: 4),
            CellFrame(left: 0, bottom: 0, right: 2, top: 3)
        ))
        XCTAssert(CellFrame.overlap(
            CellFrame(left: 1, bottom: 2, right: 3, top: 4),
            CellFrame(left: 1, bottom: 1, right: 2, top: 3)
        ))
        XCTAssert(CellFrame.overlap(
            CellFrame(left: 1, bottom: 2, right: 3, top: 4),
            CellFrame(left: 2, bottom: 1, right: 3, top: 3)
        ))
        XCTAssert(CellFrame.overlap(
            CellFrame(left: 1, bottom: 2, right: 3, top: 4),
            CellFrame(left: 2, bottom: 1, right: 2, top: 3)
        ))
        XCTAssertFalse(CellFrame.overlap(
            CellFrame(left: 1, bottom: 2, right: 3, top: 4),
            CellFrame(left: 0, bottom: 0, right: 2, top: 1)
        )) //Aren't even adjacent
        XCTAssertFalse(CellFrame.overlap(
            CellFrame(left: 2, bottom: 2, right: 4, top: 5),
            CellFrame(left: 0, bottom: 1, right: 1, top: 4)
        )) //Aren't even adjacent
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
