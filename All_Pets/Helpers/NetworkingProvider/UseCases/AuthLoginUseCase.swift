//  AuthLoginUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth

struct AuthLoginInfo {
    let password: String
    let user: String
}

protocol AuthLogin: AnyObject {
    func login(info: AuthLoginInfo,
               success: @escaping (Bool) -> Void,
               error: @escaping (Error) -> Void,
               completion: @escaping () -> Void)
}

protocol AuthLoginUseCaseProtocol: AuthLogin { }

final class AuthLoginUseCase: AuthLoginUseCaseProtocol {

    func login(info: AuthLoginInfo,
               success: @escaping (Bool) -> Void,
               error: @escaping (Error) -> Void,
               completion: @escaping () -> Void) {

        if let _ = Auth.auth().currentUser {
            success(true)
            completion()

        } else {

            Auth.auth().signIn(withEmail: info.user,
                               password: info.password) { (result, errorResponse) in

                if let _ = errorResponse {
                    error(NetworkingServerErrors.response)
                } else if let _ = result {
                    success(true)
                } else {
                    error(NetworkingServerErrors.dataNotFound)
                }

                completion()
            }
        }
    }
}
