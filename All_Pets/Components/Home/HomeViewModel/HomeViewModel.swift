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
    @Published var cites: [CiteModel] = []
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
        getCites()
    }

    func getHomeMsg() -> String {

        if let pet = petSelected {
            return getMsgCitesForHomeView(pet.id)
        } else {
            return String.MsgNoPetsRegistered
        }
    }

    func removePet(_ pet: Pet) {
        pets.removeAll { $0.id == pet.id }
        petSelected = pets.first
        useCase.deletePet(pet: pet,
                          success: {
            print("Data2 Mascota eliminada con éxito")
        }, failure: { _ in
            print("Data2 Hubo un error al eliminar la mascota")
        }, completion: {})
    }

    private func getMsgCitesForHomeView(_ idPet: String) -> String {

        if let firstCurrentCite = cites.first(where: { $0.getStatus() == .current && $0.patient == idPet }) {
            return "\(String.MsgHaveAnAppointment) \(formatDate(date: firstCurrentCite.day.dateValue()))"
        } else if cites.contains(where: { $0.getStatus() == .pending && $0.patient == idPet }) {
            return String.MsgPendingAppointments
        } else {
            return String.MsgNoPendingAppointments
        }
    }

    private func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd 'de' MMMM 'a las' h:mm a"
        return dateFormatter.string(from: date)
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

        }, failure: { _ in

        }, completion: {
            self.stopLoading()
        })
    }

    private func getCites() {

        startLoading()

        useCase.getCites(success: { cites in

            self.cites = cites

        }, failure: { _ in

        }, completion: {
            self.stopLoading()
        })
    }

    //    private func preFetchVaccinationCard(_ idPet: String) {
    //
    //        if let _ = pets.first(where: { $0.id == idPet && ($0.cardsVaccination == nil || $0.cardsVaccination!.isEmpty) }) {
    //            self.idPet = idPet
    //            getVaccinationCard(idPet)
    //        }
    //    }

    // TODO: modify
    //    private func addVaccinationCards(_ vaccinationCards: [VaccinationCardModel]) {
    //        guard let idPet = self.idPet, !idPet.isEmpty else {
    //            return
    //        }
    //
    //        if let petIndex = pets.firstIndex(where: { $0.id == idPet }) {
    //            pets[petIndex].cardsVaccination = vaccinationCards
    //        }
    //    }

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
