//  SignUpUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth

protocol SignUpProtocol: AnyObject {
    func signOut(success: @escaping (Bool) -> Void,
                 failure: @escaping (Error) -> Void,
                 completion: @escaping () -> Void)
}

protocol SignUpUseCaseProtocol: SignUpProtocol { }

final class SignUpUseCase: SignUpUseCaseProtocol { }

extension SignUpUseCase: SignUpProtocol {

    func signOut(success: @escaping (Bool) -> Void,
                 failure: @escaping (Error) -> Void,
                 completion: @escaping () -> Void) {

        do {
            try Auth.auth().signOut()
        } catch {
            failure(NetworkingClientErrors.requestInvalid)
        }
        completion()
    }
}
