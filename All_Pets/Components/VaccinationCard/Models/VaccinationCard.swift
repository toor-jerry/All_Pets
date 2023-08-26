//  VaccinationCard.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase

struct VaccinationCard: Codable {
    var day: Timestamp
    var idVet: String
    var patient: String
    var status: String
    var userId: String
    var reason: String?

    enum CodingKeys: String, CodingKey {
        case day = "day"
        case idVet = "idVeterinaria"
        case patient = "patient"
        case status = "status"
        case userId = "userId"
        case reason = "reason"
    }
}
