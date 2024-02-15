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

    func getInitData() {
        if isLoading {
            return
        }

        getCites()
    }

    func getHomeMsg(petSelected: Pet?) -> String {
// GBC
//        if let pet = petSelected {
//            return getMsgCitesForHomeView(pet.id)
//        } else {
//            return String.MsgNoPetsRegistered
//        }
        return ""
    }

    private func getMsgCitesForHomeView(_ idPet: String) -> String {

        // GBC
//        if let firstCurrentCite = cites.first(where: { $0.getStatus() == .current && $0.patient == idPet }) {
//            return "\(String.MsgHaveAnAppointment) \(formatDate(date: firstCurrentCite.day.dateValue()))"
//        } else if cites.contains(where: { $0.getStatus() == .pending && $0.patient == idPet }) {
//            return String.MsgPendingAppointments
//        } else {
//            return String.MsgNoPendingAppointments
//        }
        return ""
    }

    private func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd 'de' MMMM 'a las' h:mm a"
        return dateFormatter.string(from: date)
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
