//  VaccinationCardViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class VaccinationCardViewModel: ObservableObject {

    @Published var isLoading: Bool = false

    let useCase: VaccinationCardUseCase

    init(useCase: VaccinationCardUseCase) {
        self.useCase = useCase
    }

    func getCards() {
        isLoading = true
        useCase.getVaccinationCard { vaccinationCards in

        } failure: { _ in

        } completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        }
    }
}
