//  ProfileViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    let useCase: SignOutUseCaseProtocol

    init(useCase: SignOutUseCaseProtocol) {
        self.useCase = useCase
    }

    func signOut(completion: @escaping (_ section: AuthSections?) -> Void) {
        isLoading = true
        useCase.signOut { signOut in
            completion(.login)
        } failure: { _ in
            completion(.hub)
        } completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        }
    }
}
