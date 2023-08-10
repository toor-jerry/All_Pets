//  AuthLoginModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct AuthLoginModel: Codable {
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "mensaje"
    }
}
