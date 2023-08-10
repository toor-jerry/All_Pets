//  AuthLoginViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class AuthLoginViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    let useCase: AuthLoginUseCaseProtocol
    
    init(useCase: AuthLoginUseCaseProtocol) {
        self.useCase = useCase
    }

    func auth() {
        isLoading = true
        useCase.login(info: AuthLoginInfo(password: "12345678",
                                          user: "gerarchicharo37@gmail.com")) { response in

        } error: { responseError in

        } completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        }

    }
}
