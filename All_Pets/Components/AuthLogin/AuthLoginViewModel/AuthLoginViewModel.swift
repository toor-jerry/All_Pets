//  AuthLoginViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class AuthLoginViewModel: ObservableObject {

    @Published var section: AuthSections = .verifySessionStarted
    @Published var showAlert: Bool = false
    @Published var msgAler: String = ""
    
    private let useCase: PreAuthLoginUseCaseProtocol
    
    init(useCase: PreAuthLoginUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func auth() {
        section = .verifySessionStarted
        useCase.preAuth { isLoggedIn in
            self.section = .hub
        } error: { _ in
            self.section = .login
        } completion: { }
    }

    func login(info: AuthLoginInfo) {
        section = .loader
        preFetch(info: info)
    }

    private func preFetch(info: AuthLoginInfo) {

        if info.password.isEmpty || !isValidEmail(info.user) {
            showAlert = true
            msgAler = String.MsgFormIncomplete
            section = .login
        } else {
            fetchLogin(info)
        }
    }

    private func fetchLogin(_ info: AuthLoginInfo) {
        useCase.login(info: info) { isLoggedIn in
            self.section = .hub
        } error: { errorResponse in
            self.showAlert = true
            self.section = .login
            self.msgAler = String.MsgPasswordOrUserInvalid
        } completion: { }
    }

    func isValidEmail(_ email: String) -> Bool {

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
