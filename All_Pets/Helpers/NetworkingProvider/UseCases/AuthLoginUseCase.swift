//  AuthLoginUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth

protocol AuthLogin: AnyObject {
    func login(info: AuthLoginInfo,
               success: @escaping (Bool) -> Void,
               error: @escaping (Error) -> Void,
               completion: @escaping () -> Void)
}

protocol AuthLoginUseCaseProtocol: AuthLogin { }

final class AuthLoginUseCase: AuthLoginUseCaseProtocol { }

extension AuthLoginUseCase: AuthLogin {
    
    func login(info: AuthLoginInfo,
               success: @escaping (Bool) -> Void,
               error: @escaping (Error) -> Void,
               completion: @escaping () -> Void) {

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
