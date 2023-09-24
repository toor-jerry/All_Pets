//  CreateAppointment.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 22/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct CreateAppointment: Codable {
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "mensaje"
    }
}
