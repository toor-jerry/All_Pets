//  ProfileViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {

    let useCase: SignUpUseCaseProtocol

    init(useCase: SignUpUseCaseProtocol) {
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
}
