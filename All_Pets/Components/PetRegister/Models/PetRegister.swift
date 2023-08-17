//  PetRegister.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import Firebase

struct PetRegister: Codable {
    var name: String
    var petType: String
    var birthDate: Timestamp
    var pet: String
    var photo: UIImage?
    var photoURL: String?

    enum CodingKeys: String, CodingKey {
        case name = "Nombre"
        case birthDate = "Fecha_Nacimiento"
        case photoURL = "ImgUrl"
        case petType = "Raza"
        case pet = "Mascota"
    }

    init(name: String, petType: String, birthDate: Date, pet: String, photo: UIImage? = nil, photoURL: String? = nil) {
        self.name = name
        self.petType = petType
        self.birthDate = Timestamp(date: birthDate)
        self.pet = pet
        self.photo = photo
        self.photoURL = photoURL
    }

    init(name: String, petType: String, birthDate: Timestamp, pet: String, photo: UIImage? = nil, photoURL: String? = nil) {
        self.name = name
        self.petType = petType
        self.birthDate = birthDate
        self.pet = pet
        self.photo = photo
        self.photoURL = photoURL
    }
}
