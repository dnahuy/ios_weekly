//
//  ConstantsTests.swift
//  FaceITTests
//
//  Created by Steven Curtis on 19/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import FaceIT

class ConstantsTests: XCTestCase {
    func testPageOne() {
        XCTAssertEqual(API.getUsers(pageIndex: 1).url!, URL(string:"https://reqres.in/api/users?page=1"))
    }
    func testPageTwo() {
        XCTAssertEqual(API.getUsers(pageIndex: 2).url!, URL(string:"https://reqres.in/api/users?page=2"))
    }
    func testPageTwoDigits() {
        XCTAssertEqual(API.getUsers(pageIndex: 99).url!, URL(string:"https://reqres.in/api/users?page=99"))
    }
    func testPostregister() {
        XCTAssertEqual(API.postRegister.url, URL(string:"https://reqres.in/api/register"))
    }
}
