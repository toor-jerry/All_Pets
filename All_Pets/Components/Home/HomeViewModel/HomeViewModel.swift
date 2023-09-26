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
    @Published var cites: [CiteModel] = []

    private var callService: Int = .zero

    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }

    func getInitData(completion: @escaping (_ pets: [Pet], _ petSelected: Pet?) -> Void) {
        if isLoading {
            return
        }

        getPets(completion: completion)
        getCites()
    }

    func getHomeMsg(petSelected: Pet?) -> String {

        if let pet = petSelected {
            return getMsgCitesForHomeView(pet.id)
        } else {
            return String.MsgNoPetsRegistered
        }
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

    private func getPets(completion: @escaping (_ pets: [Pet], _ petSelected: Pet?) -> Void) {

        startLoading()

        useCase.getPets(success: { pets in

            completion(pets, pets.first)

        }, failure: { _ in
            completion([], nil)
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
