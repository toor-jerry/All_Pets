//  ChipModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 03/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ChipModel {
    var isSelected: Bool
    var id: UUID
    let titleKey: String
    let systemImage: String?

    init(titleKey: String, isSelected: Bool = false, systemImage: String? = nil, id: UUID = UUID()) {
        self.isSelected = isSelected
        self.systemImage = systemImage
        self.titleKey = titleKey
        self.id = id
    }
}
