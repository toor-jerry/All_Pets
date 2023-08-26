//  VaccinationCard.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct VaccinationCard: Codable {
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "mensaje"
    }
}
