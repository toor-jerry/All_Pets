//  AuthLoginViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class AuthLoginViewModel: ObservableObject {
    
    @Published var isLoading: Bool = true
    @Published var isLoggedIn: Bool = false
    
    let useCase: PreAuthLoginUseCaseProtocol
    
    init(useCase: PreAuthLoginUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func auth() {
        isLoading = true
        useCase.preAuth { isLoggedIn in
            self.isLoggedIn = isLoggedIn
        } error: { _ in
            self.isLoggedIn = false
        } completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        }
    }
}
