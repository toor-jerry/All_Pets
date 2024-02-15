//  UserModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 17/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

struct User: Codable {

    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "Nombre"
    }

    init(name: String = "") {
        self.name = name
    }
}
