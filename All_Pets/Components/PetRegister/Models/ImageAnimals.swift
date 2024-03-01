//  ImageAnimals.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 29/02/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

enum ImageAnimals: String {
    case bird
    case cat
    case dog
    case fish
}

extension ImageAnimals {
    
    func getImage() -> Image {
        switch self {
        case .bird:
            return Image.bird
        case .cat:
            return Image.cat
        case .dog:
            return Image.dog
        case .fish:
            return Image.fish
        }
    }
}
