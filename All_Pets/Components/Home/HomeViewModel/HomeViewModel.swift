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
    
    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }

    func getUser() {
        isLoading = true
        useCase.getUser(success: { user in
            if let pets = user.pets {
                for pet in pets {
                    print("Data2 Pet Name: \(pet.name), Type: \(pet.birthDate)")
                }
            } else {
                print("Data2 User has no pets.")
            }
        }, failure: { _ in

        }, completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        })
    }
}
