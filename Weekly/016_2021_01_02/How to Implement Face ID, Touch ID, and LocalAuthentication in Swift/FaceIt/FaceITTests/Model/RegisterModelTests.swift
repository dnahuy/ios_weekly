//
//  RegisterModelTests.swift
//  FaceITTests
//
//  Created by Steven Curtis on 20/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import FaceIT

class RegisterModelTests: XCTestCase {
    
    let registerString = """
    {
    "id": 1,
    "token": "QpwL5tke4Pnpja7X4"
    }
    """
    
    let secondRegisterString = """
    {
    "id": 2,
    "token": "QpwL5tke4Pnpja7X5"
    }
    """

    func testRegister() {
        let decoded = try! JSONDecoder().decode(RegisterModel.self, from: Data(registerString.utf8))
        XCTAssertEqual(decoded.token, "QpwL5tke4Pnpja7X4")
        XCTAssertEqual(decoded.id, 1)
    }
    
    func testRegisterModelEqual() {
        let tokenOne = try! JSONDecoder().decode(RegisterModel.self, from: Data(registerString.utf8))
        let tokenTwo = try! JSONDecoder().decode(RegisterModel.self, from: Data(registerString.utf8))
        XCTAssertEqual(tokenOne, tokenTwo)

    }
    
    func testRegisterModelNotEqual() {
        let tokenOne = try! JSONDecoder().decode(RegisterModel.self, from: Data(registerString.utf8))
        let tokenTwo = try! JSONDecoder().decode(RegisterModel.self, from: Data(secondRegisterString.utf8))
        XCTAssertNotEqual(tokenOne, tokenTwo)
    }

    

}
