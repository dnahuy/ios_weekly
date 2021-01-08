//
//  LAContextProtocol.swift
//  FaceIT
//
//  Created by Steven Curtis on 20/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import LocalAuthentication

protocol LAContextProtocol {
    func canEvaluatePolicy(_ : LAPolicy, error: NSErrorPointer) -> Bool
    func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void)
}
