//  ForgotPasswordViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/02/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class ForgotPasswordViewModel: ObservableObject {
    
    let useCase: ForgotPasswordProtocol
    
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false
    
    init(useCase: ForgotPasswordProtocol) {
        self.useCase = useCase
    }
    
    func forgotPassword(email: String) {
        isLoading = true
        useCase.forgotPassword(email: email,
                               success: { 
            self.isSuccess = true
        },
                               error: { _ in
        }, completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        })
    }
}
