//  vaccinationCardModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 21/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase

struct VaccinationCardModel: Codable {

    var professionalLicense: String
    var vaccinationDate: Timestamp
    var status: String
    var vaccine: String

    enum CodingKeys: String, CodingKey {
        case professionalLicense = "PLicense"
        case vaccinationDate = "date"
        case status = "status"
        case vaccine = "vaccine"
    }
}
