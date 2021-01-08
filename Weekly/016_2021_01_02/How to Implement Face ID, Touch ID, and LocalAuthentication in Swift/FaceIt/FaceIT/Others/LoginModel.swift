//
//  LoginModel.swift
//  FaceIT
//
//  Created by Steven Curtis on 20/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

public struct LoginModel: Codable, Equatable {
    public var token : String
    
    private enum CodingKeys: String, CodingKey {
        case token
    }
    
    public static func == (lhs: LoginModel, rhs: LoginModel) -> Bool {
        return lhs.token == rhs.token
    }
}
