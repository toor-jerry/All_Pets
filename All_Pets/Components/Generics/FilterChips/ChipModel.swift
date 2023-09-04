//  ChipModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 03/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ChipModel: Identifiable {
    @State var isSelected: Bool
    let id = UUID()
    let systemImage: String
    let titleKey: LocalizedStringKey
}
