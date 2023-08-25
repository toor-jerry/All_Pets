//  HomeViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 17/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class HomeViewModelViewModel: ObservableObject {

    let useCase: HomeUseCaseProtocol

    @Published var isLoading: Bool = false
    @Published var user: User = User()
    @Published var pets: [Pet] = []
    @Published var petSelected: Pet?
    private var idPet: String?

    private var callService: Int = .zero
    
    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }

    func getInitData() {
        if isLoading {
            return
        }

        getUser()
        getPets()
    }

    private func getUser() {

        startLoading()
        useCase.getUser(success: { user in
            self.user = user
        }, failure: { _ in

        }, completion: {
            self.stopLoading()
        })
    }

    private func getPets() {

        startLoading()

        useCase.getPets(success: { pets in

            self.pets = pets
            self.petSelected = pets.first

            if let idPet = pets.first?.id, !idPet.isEmpty {
                self.preFetchVaccinationCard(idPet)
            }
        }, failure: { _ in

        }, completion: {
            self.stopLoading()
        })
    }

    private func preFetchVaccinationCard(_ idPet: String) {

        if let _ = pets.first(where: { $0.id == idPet && ($0.cardsVaccination == nil || $0.cardsVaccination!.isEmpty) }) {
            self.idPet = idPet
            getVaccinationCard(idPet)
        }
    }


    private func getVaccinationCard(_ idPet: String) {

        startLoading()

        useCase.getVaccinationCard(idPet,
                                   success: { vaccinationCards in
            self.addVaccinationCards(vaccinationCards)
        }, failure: { _ in

        }, completion: {
            self.stopLoading()
        })
    }

    private func addVaccinationCards(_ vaccinationCards: [VaccinationCardModel]) {
        guard let idPet = self.idPet, !idPet.isEmpty else {
            return
        }

        if let petIndex = pets.firstIndex(where: { $0.id == idPet }) {
            pets[petIndex].cardsVaccination = vaccinationCards
        }
    }

    private func startLoading() {
        isLoading = true
        callService += 1
    }

    private func stopLoading() {
        callService -= 1

        if callService <= .zero {
            setTheardMain {
                self.isLoading = false
            }

            callService = .zero
        }
    }
}
