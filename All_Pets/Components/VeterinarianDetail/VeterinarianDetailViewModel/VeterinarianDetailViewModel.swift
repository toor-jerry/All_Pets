//  VeterinarianDetailViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 06/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class VeterinarianDetailViewModel: ObservableObject {

    @Published var chipsSpecialities: [ChipModel] = []

    func setup(_ office: OfficeModel) {
        var specialitiesTmp: [ChipModel] = []
        office.medicalSpecialities?.forEach({ specialitie in
            specialitiesTmp.append(ChipModel(titleKey: specialitie))
        })

        setTheardMain {
            self.chipsSpecialities = specialitiesTmp
        }
    }
}
