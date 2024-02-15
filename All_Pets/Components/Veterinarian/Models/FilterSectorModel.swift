//  FilterSectorModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 01/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

struct FilterSector: Hashable {
    let sector: String
    var isSelected: Bool

    init(_ sector: String, isSelected: Bool = false) {
        self.sector = sector
        self.isSelected = isSelected
    }
}
