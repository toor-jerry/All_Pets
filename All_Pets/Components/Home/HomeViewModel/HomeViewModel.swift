//  HomeViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 17/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class HomeViewModelViewModel: ObservableObject {

    let useCase: HomeUseCaseProtocol

    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }

//    func auth() {
//        isLoading = true
//        useCase.preAuth { isLoggedIn in
//            self.isLoggedIn = isLoggedIn
//        } error: { _ in
//            self.isLoggedIn = false
//        } completion: {
//            self.setTheardMain {
//                self.isLoading = false
//            }
//        }
//    getUserByID(userID: "user123") { result in
//        switch result {
//        case .success(let user):
//            if let pets = user.pets {
//                for pet in pets {
//                    print("Pet Name: \(pet.name), Type: \(pet.type)")
//                }
//            } else {
//                print("User has no pets.")
//            }
//        case .failure(let error):
//            print("Error: \(error.localizedDescription)")
//        }
//    }
}
