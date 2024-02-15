//  Endpoint.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 12/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

enum Endpoint {
    case usersCollection
    case typePets
    case petsCollection
    case imagePets(_ idCollection: String)
    case vaccinationCard
    case citesCollection
    case officesCollection
    case businessCollection
}

extension Endpoint {

    var urlString: String {

        switch self {
        case .usersCollection:
            return "Users"
        case .typePets:
            return "Tipo_mascotas"
        case .petsCollection:
            return "Mascotas"
        case .imagePets(idCollection: let idCollection):
            return "images/Ym9GsB7d7KcS7iKHJ6WuxYGkqDM2/pets/\(idCollection)/\(idCollection)"
        case .vaccinationCard:
            return "Cartilla"
        case .citesCollection:
            return "Citas"
        case .officesCollection:
            return "Consultorios"
        case .businessCollection:
            return "Negocios"
        }
    }
}
