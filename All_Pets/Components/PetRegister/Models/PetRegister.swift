//  PetRegister.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import Firebase

struct PetRegister: Codable {

    var id: String?
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

    init(birthDate: Date, pet: String, photoURL: String? = nil, name: String? = nil, petType: String? = nil) {
        self.name = name
        self.petType = petType
        self.birthDate = Timestamp(date: birthDate)
        self.pet = pet
        self.photoURL = photoURL
    }

    init(birthDate: Timestamp, pet: String, photoURL: String? = nil, name: String? = nil, petType: String? = nil) {
        self.name = name
        self.petType = petType
        self.birthDate = birthDate
        self.pet = pet
        self.photoURL = photoURL
    }


    func getData(_ urlString: String? = nil) -> PetRegister {
        return PetRegister(birthDate: self.birthDate,
                           pet: self.pet,
                           photoURL: urlString,
                           name: self.name?.isEmpty ?? false ? nil : self.name,
                           petType: self.petType?.contains(.MsgSelectTypePet) ?? false ? nil : self.petType)
    }
}
