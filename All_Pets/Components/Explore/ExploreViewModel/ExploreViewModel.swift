//  ExploreViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/10/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class ExploreViewModel: ObservableObject {

    let useCase: ExploreUseCaseProtocol

    @Published var isLoading: Bool = false
    @Published var business: [BusinessModel] = []

    init(useCase: ExploreUseCaseProtocol) {
        self.useCase = useCase
    }

    func getBusiness() {
        isLoading = true
        useCase.getBusiness(success: { business in
            self.business = business
        }, failure: { _ in

        }, completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        })
    }
}
