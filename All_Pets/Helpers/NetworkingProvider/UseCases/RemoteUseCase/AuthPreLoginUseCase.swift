//  AuthPreLoginUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 10/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth
import AllPetsNetworkProvider

protocol PreAuthLoginProtocol: AnyObject {

    func preAuth(success: @escaping (Bool) -> Void,
                 error: @escaping (Error) -> Void,
                 completion: @escaping () -> Void)
}

protocol AuthLoginProtocol: AnyObject {

    func login(info: AuthLoginInfo,
               success: @escaping (Bool) -> Void,
               error: @escaping (Error) -> Void,
               completion: @escaping () -> Void)
}

protocol PreAuthLoginUseCaseProtocol: PreAuthLoginProtocol, AuthLoginProtocol { }

final class PreAuthLoginUseCase: PreAuthLoginUseCaseProtocol { }

extension PreAuthLoginUseCase: PreAuthLoginProtocol {

    func preAuth(success: @escaping (Bool) -> Void,
                 error: @escaping (Error) -> Void,
                 completion: @escaping () -> Void) {
        
        if let _ = Auth.auth().currentUser {
            success(true)
        } else {
            error(NetworkingServerErrors.dataNotFound)
        }

        completion()
    }
}

extension PreAuthLoginUseCase: AuthLoginProtocol {

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
