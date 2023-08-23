//  PetModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 21/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase

struct Pet: Codable {

    var id: String
    var birthDate: Timestamp
    var pet: String
    var petType: String?
    var name: String?
    var photoURL: String?
    var cardsVaccination: [VaccinationCardModel]?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "Nombre"
        case birthDate = "Fecha_Nacimiento"
        case photoURL = "ImgUrl"
        case petType = "Raza"
        case pet = "Mascota"
    }
}
