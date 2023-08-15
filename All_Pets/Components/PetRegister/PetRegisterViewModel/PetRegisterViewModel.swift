//  PetRegisterViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class PetRegisterViewModel: ObservableObject {

    @Published var isLoading: Bool = false
    let useCase: PetRegisterUseCaseProtocol

    init(useCase: PetRegisterUseCaseProtocol) {
        self.useCase = useCase
    }

    func getPetsType() {
        isLoading = true
        useCase.getPetTypes(success: { types in
            
        }, failure: { _ in

        }, completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        })
    }
}
