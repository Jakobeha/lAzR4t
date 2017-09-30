//
//  ListTests.swift
//  lAzR4tTests
//
//  Created by Jakob Hain on 9/30/17.
//  Copyright © 2017 Jakob Hain. All rights reserved.
//

import XCTest
@testable import lAzR4t

class ListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEquality() {
        XCTAssert(List<String>.empty == List<String>.empty)
        XCTAssert(
            List.cons(head: "A", rest: List.cons(head: "B", rest: List.cons(head: "C", rest: List<String>.empty))) ==
            List.cons(head: "A", rest: List.cons(head: "B", rest: List.cons(head: "C", rest: List<String>.empty)))
        )
        XCTAssert(
            List.cons(head: "A", rest: List.cons(head: "B", rest: List.cons(head: "C", rest: List<String>.empty))) !=
            List.cons(head: "A", rest: List.cons(head: "B", rest: List.cons(head: "D", rest: List<String>.empty)))
            )
        XCTAssert(
            List.cons(head: "A", rest: List.cons(head: "B", rest: List.cons(head: "C", rest: List<String>.empty))) !=
            List.cons(head: "A", rest: List.cons(head: "B", rest: List<String>.empty))
        )
        XCTAssert(
            List.cons(head: "B", rest: List.cons(head: "C", rest: List<String>.empty)) !=
            List.cons(head: "A", rest: List.cons(head: "B", rest: List.cons(head: "C", rest: List<String>.empty)))
        )
    }
    
    func testFromArray() {
        XCTAssert(List(fromArray: []) == List<String>.empty)
        XCTAssert(
            List(fromArray: ["a", "b", "c"]) ==
            List.cons(head: "a", rest: List.cons(head: "b", rest: List.cons(head: "c", rest: List<String>.empty)))
        )
        XCTAssert(
            List(fromArray: ["a", "b", "c"]) !=
            List.cons(head: "a", rest: List.cons(head: "b", rest: List<String>.empty))
        )
    }
    
    func testToArray() {
        XCTAssert(List<String>.empty.toArray == [])
        XCTAssertNotEqual(List(fromArray: ["a", "b", "c"]).toArray, ["a", "b"])
        XCTAssertEqual(List(fromArray: ["a", "b", "c"]).toArray, ["a", "b", "c"])
    }
    
    func testContains() {
        XCTAssertTrue(List(fromArray: ["A", "b", "C"]).contains { (x: String) in x.lowercased() == x })
        XCTAssertFalse(List(fromArray: ["A", "B", "C"]).contains { (x: String) in x.lowercased() == x })
        XCTAssertTrue(List(fromArray: ["A", "B", "C"]).contains("A"))
        XCTAssertFalse(List(fromArray: ["A", "B", "C"]).contains("D"))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
