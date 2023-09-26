//  SessionInfoCustom.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

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
    
    func getUser() {

        useCase.getUser(success: { user in
            self.user = user
        }, failure: { _ in

        }, completion: { })
    }
}
