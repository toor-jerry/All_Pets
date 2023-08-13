//  Endpoint.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 12/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

enum Endpoint {
    case usersCollection
}

extension Endpoint {
    var urlString: String {
        switch self {
        case .usersCollection:
            return "Users"
        }
    }
}
