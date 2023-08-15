//  PetRegisterUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase
import FirebaseFirestoreSwift

protocol PetTypesProtocol: AnyObject {
    func getPetTypes(success: @escaping (_ types: [String: [String]]) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void)
}

protocol PetRegisterUseCaseProtocol: PetTypesProtocol { }

final class PetRegisterUseCase: PetRegisterUseCaseProtocol { }

extension PetRegisterUseCase: PetTypesProtocol {

    func getPetTypes(success: @escaping (_ types: [String: [String]]) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void) {

        let db = Firestore.firestore()
        let typePets = db.collection(Endpoint.typePets.urlString).document(Constants.documentIdPetTypes)

        typePets.getDocument { document, error in

            if let _ = error {
                failure(NetworkingServerErrors.dataNotFound)
            } else if let document = document, document.exists {
                if let data = document.data() as? [String: [String]] {
                    success(data)
                } else {
                    failure(NetworkingServerErrors.response)
                }
            }

            completion()
        }
    }
}
