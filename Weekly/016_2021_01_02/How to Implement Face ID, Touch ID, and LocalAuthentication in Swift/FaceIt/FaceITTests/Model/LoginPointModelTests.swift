//
//  EndPointModelTests.swift
//  FaceITTests
//
//  Created by Steven Curtis on 20/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import FaceIT

class LoginModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    let loginString = """
    {
    "token": "QpwL5tke4Pnpja7X4"
    }
    """
    
    let secondLoginString = """
    {
    "token": "QpwL5tke4Pnpja7X5"
    }
    """

    func testLogin() {
        let decoded = try! JSONDecoder().decode(LoginModel.self, from: Data(loginString.utf8))
        XCTAssertEqual(decoded.token, "QpwL5tke4Pnpja7X4")
    }
    
    func testLoginModelEqual() {
        let tokenOne = try! JSONDecoder().decode(LoginModel.self, from: Data(loginString.utf8))
        let tokenTwo = try! JSONDecoder().decode(LoginModel.self, from: Data(loginString.utf8))
        XCTAssertEqual(tokenOne, tokenTwo)
    }
    
    func testLoginModelNotEqual() {
        let tokenOne = try! JSONDecoder().decode(LoginModel.self, from: Data(loginString.utf8))
        let tokenTwo = try! JSONDecoder().decode(LoginModel.self, from: Data(secondLoginString.utf8))
        XCTAssertNotEqual(tokenOne, tokenTwo)
    }


}
