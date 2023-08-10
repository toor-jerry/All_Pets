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
    @Published var showAlert: Bool = false

    let useCase: AuthLoginUseCase

    init(useCase: AuthLoginUseCase) {
        self.useCase = useCase
    }

    func login(info: AuthLoginInfo) {
        isLoading = true
        preFetch(info: info)
    }

    private func preFetch(info: AuthLoginInfo) {

        if info.password.isEmpty || !isValidEmail(info.user) {
            showAlert = true
            stopLoading()
        } else {
            fetchLogin(info)
        }
    }

    private func fetchLogin(_ info: AuthLoginInfo) {
        useCase.login(info: info) { isLoggedIn in
            self.isLoggedIn = true
        } error: { errorResponse in
            self.showAlert = true
        } completion: {
            self.stopLoading()
        }
    }

    private func isValidEmail(_ email: String) -> Bool {

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    private func stopLoading() {
        setTheardMain {
            self.isLoading = false
        }
    }
}
