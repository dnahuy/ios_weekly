//
//  RegisterModel.swift
//  FaceIT
//
//  Created by Steven Curtis on 20/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

public struct RegisterModel: Codable, Equatable {
    public var id: Int
    public var token : String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case token
    }
    
    public static func == (lhs: RegisterModel, rhs: RegisterModel) -> Bool {
        return lhs.id == rhs.id
    }
}
