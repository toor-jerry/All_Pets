//  VeterianUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 31/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth

protocol VeterianUseCaseProtocol: AnyObject {

    func preAuth(success: @escaping (Bool) -> Void,
                 error: @escaping (Error) -> Void,
                 completion: @escaping () -> Void)
}

protocol VeterianUseCaseUseCaseProtocol: VeterianUseCaseProtocol { }

final class VeterianUseCaseUseCase: VeterianUseCaseUseCaseProtocol { }

extension VeterianUseCaseUseCase: VeterianUseCaseProtocol {

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
