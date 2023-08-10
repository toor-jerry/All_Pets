//  LoginViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 10/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class LoginViewModel: ObservableObject {

    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false

    let useCase: AuthLoginUseCase

    init(useCase: AuthLoginUseCase) {
        self.useCase = useCase
    }

    func login(info: AuthLoginInfo) {
        isLoading = true
        useCase.login(info: info) { isLoggedIn in

        } error: { errorResponse in

        } completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        }
    }
}
