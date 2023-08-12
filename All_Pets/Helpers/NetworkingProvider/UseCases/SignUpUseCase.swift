//  SignUpUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth

protocol SignUpProtocol: AnyObject {
    func signUp(data: SignUpModel,
                success: @escaping (_ idUser: String) -> Void,
                 failure: @escaping (Error) -> Void,
                 completion: @escaping () -> Void)
}

protocol SignUpUseCaseProtocol: SignUpProtocol { }

final class SignUpUseCase: SignUpUseCaseProtocol { }

extension SignUpUseCase: SignUpProtocol {

    func signUp(data: SignUpModel,
                 success: @escaping (_ idUser: String) -> Void,
                 failure: @escaping (Error) -> Void,
                 completion: @escaping () -> Void) {

//        Auth.auth().signIn(withEmail: info.user,
//                           password: info.password) { (result, errorResponse) in
//
//            if let _ = errorResponse {
//                error(NetworkingServerErrors.response)
//            } else if let _ = result {
//                success(true)
//            } else {
//                error(NetworkingServerErrors.dataNotFound)
//            }
//
//            completion()
//        }
    }
}
