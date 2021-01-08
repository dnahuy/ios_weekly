//
//  Constants.swift
//  FaceIT
//
//  Created by Steven Curtis on 17/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

public class APIKeys {
    // Insert API Key here
    static let APIKey = "tN3lr7Uvgd2CSnTAGlgpNkrupQWpEESn"
}

enum API {
    case getUsers(pageIndex: Int)
    case postRegister
    case postLogin
    
    var url: URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "reqres.in"
        component.path = path
        component.queryItems = pageQuery()
        return component.url
    }
    
    func pageQuery()-> [URLQueryItem]? {
        switch self {
        case .getUsers(let page):
            return [URLQueryItem(name: "page", value: page.description)]
        case .postRegister: return nil
        default: return nil
        }
    }
}

extension API {
    fileprivate var path: String {
        switch self {
        case .getUsers:
            return "/api/users"
        case .postRegister:
            return "/api/register"
        case .postLogin:
            return "/api/login"
        }
    }
}
