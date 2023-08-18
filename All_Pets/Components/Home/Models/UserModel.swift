//  UserModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 17/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase

struct User: Codable {
    let name: String
    var pets: [Pet]?

    enum CodingKeys: String, CodingKey {
        case name = "Nombre"
        case pets = "Mascotas"
    }
}

struct Pet: Codable {

    var birthDate: Timestamp
    var pet: String
    var petType: String?
    var name: String?
    var photoURL: String?

    enum CodingKeys: String, CodingKey {
        case name = "Nombre"
        case birthDate = "Fecha_Nacimiento"
        case photoURL = "ImgUrl"
        case petType = "Raza"
        case pet = "Mascota"
    }
}
