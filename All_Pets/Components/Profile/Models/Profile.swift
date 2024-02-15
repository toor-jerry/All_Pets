//  Profile.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct Profile: Codable {
    // TODO: REMOVE THIS
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "mensaje"
    }
}
