//
//  LAContextMock.swift
//  FaceITTests
//
//  Created by Steven Curtis on 20/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import LocalAuthentication

@testable import FaceIT

class LAContextMock: LAContextProtocol {
    var canEval = true
    func canEvaluatePolicy(_: LAPolicy, error: NSErrorPointer) -> Bool {
        return canEval
    }
    
    func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void) {
        // returning nil implies that there are no errors, therefore we are authenticated
        reply(true, nil)
    }
}
