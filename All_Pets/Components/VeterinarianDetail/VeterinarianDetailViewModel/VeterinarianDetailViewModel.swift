//  VeterinarianDetailViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 06/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import AllPetsCommons

final class VeterinarianDetailViewModel: ObservableObject {

    @Published var chipsSpecialities: [ChipModel] = []
    @Published var chipsSectors: [ChipModel] = []

    func setup(_ office: OfficeModel) {
        var specialitiesTmp: [ChipModel] = []
        var sectorsTmp: [ChipModel] = []

        office.medicalSpecialities?.forEach({ specialitie in
            specialitiesTmp.append(ChipModel(titleKey: specialitie))
        })

        office.specializedSector?.forEach({ sector in
            sectorsTmp.append(ChipModel(titleKey: sector))
        })

        setTheardMain {
            self.chipsSpecialities = specialitiesTmp
            self.chipsSectors = sectorsTmp
        }
    }
}
