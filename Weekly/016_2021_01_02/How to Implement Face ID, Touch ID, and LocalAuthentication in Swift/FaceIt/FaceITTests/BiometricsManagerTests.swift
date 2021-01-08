//
//  BiometricsManagerTests.swift
//  FaceITTests
//
//  Created by Steven Curtis on 20/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import FaceIT


class BiometricsManagerTests: XCTestCase {
    
    /// This doesn't really test anything, as the mock always returns true
    func testBMEval() {
        let bm = BiometricsManager(context: LAContextMock())
        XCTAssertEqual(bm.canEvaluatePolicy(), true)
    }
    
    func testAuthUser() {
        let bm = BiometricsManager(context: LAContextMock())
        let exp = expectation(description: "Auth User Exp")
        bm.authenticateUser(completion: {ret in
            print (ret)
            switch ret {
            case .failure: XCTFail()
            case .success(let success): XCTAssertEqual(success, "Success")
            }
            exp.fulfill()
        })
        waitForExpectations(timeout: 2.0)
    }
    
    func testAuthUserCantEvaluate() {
        let laMock = LAContextMock()
        laMock.canEval = false
        let exp = expectation(description: "Auth User Exp")
        let bm = BiometricsManager(context: laMock)
        bm.authenticateUser(completion: {ret in
            print (ret)
            switch ret {
            case .failure(let fail):
                let err = BioError.NoEvaluate
                XCTAssertEqual(err.hashValue, (fail as! BioError).hashValue)
            case .success: XCTFail()
            }
            exp.fulfill()
        })
        waitForExpectations(timeout: 2.0)

    }

}
