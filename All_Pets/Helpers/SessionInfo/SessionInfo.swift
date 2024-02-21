//  SessionInfo.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import OSLog

final class SessionInfo: ObservableObject {

    @Published var user: User = User()
    @Published var pets: [Pet] = []
    @Published var petSelected: Pet? = nil
    
    private let useCase: SessionInfoProtocols

    init() {
        self.useCase = SessionInfoUseCase()
    }

    func getInitData() {
        getUser()
        getPets()
    }

    func removePet(_ pet: Pet) {
        pets.removeAll { $0.id == pet.id }
        petSelected = pets.first
        useCase.deletePet(pet: pet,
                          success: {
            Logger().info("Mascota eliminada con éxito")
            print("Data2 Mascota eliminada con éxito")
        }, failure: { _ in
            Logger().error("Hubo un error al eliminar la mascota")
        }, completion: {})
    }

    func getPets() {

        useCase.getPets(success: { pets in

            self.pets = pets
            if let pet = self.petSelected {
                self.petSelected = pet
            } else {
                self.petSelected = pets.first
            }

        }, failure: { _ in },
                        completion: { })
    }

    func getUser() {

        useCase.getUser(success: { user in
            self.user = user
        }, failure: { _ in

        }, completion: { })
    }
}
