//  VaccinationCardViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class VaccinationCardViewModel: ObservableObject {

    @Published var isLoading: Bool = false
    @Published var cards: [VaccinationCardModel] = []

    let useCase: VaccinationCardUseCase

    init(useCase: VaccinationCardUseCase) {
        self.useCase = useCase
    }

    func getCards(_ idPet: String) {
        if idPet.isEmpty {
            return
        }
        
        isLoading = true
        useCase.getVaccinationCard(idPet,
                                   success: { vaccinationCards in
            self.cards =  vaccinationCards
            self.cards.insert(contentsOf: vaccinationCards, at: 0)
        }, failure: { _ in

        }, completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        })
    }
}
