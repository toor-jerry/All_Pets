//  Endpoint.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 12/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

enum Endpoint {
    case usersCollection
    case typePets
}

extension Endpoint {

    var urlString: String {

        switch self {
        case .usersCollection:
            return "Users"
        case .typePets:
            return "Tipo_mascotas"
        }
    }
}
