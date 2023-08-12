//  SignUpViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class SignUpViewModelViewModel: ObservableObject {

    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    
    let useCase: SignUpUseCaseProtocol
    
    init(useCase: SignUpUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func signUp(data: SignUpModel) {
        isLoading = true
        useCase.signUp(data: data, success: { _ in
            
        }, failure: { _ in
            
        }, completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        })
    }
}
