//
//  TouchIDManager.swift
//  FaceIT
//
//  Created by Steven Curtis on 20/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import LocalAuthentication

enum BioError: Error {
    case General
    case NoEvaluate
}

class BiometricsManager {
    let context: LAContextProtocol
    
    init(context: LAContextProtocol = LAContext() ) {
        self.context = context
    }
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
   
    func authenticateUser(completion: @escaping (Result<String, Error>) -> Void) {
        guard canEvaluatePolicy() else {
            completion( .failure(BioError.NoEvaluate) )
            return
        }
        
        let loginReason = "Log in with Biometrics"
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: loginReason) { (success, evaluateError) in
            if success {
                DispatchQueue.main.async {
                    // User authenticated successfully
                    completion(.success("Success"))
                }
            } else {
                switch evaluateError {
                default: completion(.failure(BioError.General))
                }

            }
        }
    }
}
