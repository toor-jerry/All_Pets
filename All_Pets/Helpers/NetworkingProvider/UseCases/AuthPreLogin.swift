//  AuthPreLogin.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 10/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth

protocol PreAuthLogin: AnyObject {
    func preAuth(success: @escaping (Bool) -> Void,
                 error: @escaping (Error) -> Void,
                 completion: @escaping () -> Void)
}

protocol PreAuthLoginProtocol: PreAuthLogin { }

final class PreAuthLoginUseCase: PreAuthLoginProtocol {

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
