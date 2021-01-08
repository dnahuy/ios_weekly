//
//  TestingHelperFunctions.swift
//  KeychainImplementationTests
//
//  Created by Steven Curtis on 15/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

public func ==(lhs: [String: Any], rhs: [String: Any] ) -> Bool {
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}
