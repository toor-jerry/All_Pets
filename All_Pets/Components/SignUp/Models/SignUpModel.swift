//  SignUpModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase

struct SignUpModel: Codable {
    var name: String
    var firstLastName: String
    var secondLastName: String
    var email: String
    var password: String

    init(name: String = "",
         firstLastName: String = "",
         secondLastName: String = "",
         email: String = "",
         password: String = "") {
        self.name = name
        self.firstLastName = firstLastName
        self.secondLastName = secondLastName
        self.email = email
        self.password = password
    }

    enum CodingKeys: String, CodingKey {
        case name = "Nombre"
        case firstLastName = "Apellido_Paterno"
        case secondLastName = "Apellido_Materno"
        case email = "Correo"
        case password
    }
}
