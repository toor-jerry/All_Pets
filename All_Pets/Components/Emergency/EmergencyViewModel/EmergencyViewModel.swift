//  EmergencyViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 28/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class EmergencyViewModel: ObservableObject {

    let useCase: EmergencyUseCaseProtocol

    @Published var isLoading: Bool = false

    init(useCase: EmergencyUseCaseProtocol) {
        self.useCase = useCase
    }

    func getOffices() {
        isLoading = true
        useCase.getOffices(success: { offices in

        }, failure: { _ in

        }, completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        })
    }
}
