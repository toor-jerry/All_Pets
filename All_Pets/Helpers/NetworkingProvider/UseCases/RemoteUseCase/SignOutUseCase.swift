//  SignOutUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth
import AllPetsNetworkProvider

protocol SignOutProtocol: AnyObject {
    func signOut(success: @escaping (Bool) -> Void,
                 failure: @escaping (Error) -> Void,
                 completion: @escaping () -> Void)
}

protocol SignOutUseCaseProtocol: SignOutProtocol { }

final class SignOutUseCase: SignOutUseCaseProtocol { }

extension SignOutUseCase: SignOutProtocol {

    func signOut(success: @escaping (Bool) -> Void,
                 failure: @escaping (Error) -> Void,
                 completion: @escaping () -> Void) {

        do {
            try Auth.auth().signOut()
            success(true)
        } catch {
            failure(NetworkingServerErrors.unknownError)
        }
        completion()
    }
}
