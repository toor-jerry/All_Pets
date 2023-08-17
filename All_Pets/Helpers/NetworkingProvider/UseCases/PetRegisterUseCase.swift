//  PetRegisterUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

protocol PetRegisterProtocol: AnyObject {
    func petRegister(data: PetRegister,
                     success: @escaping (_ registed: Bool) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void)
}

protocol PetTypesProtocol: AnyObject {
    func getPetTypes(success: @escaping (_ types: [String: [String]]) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void)
}

protocol PetRegisterUseCaseProtocol: PetTypesProtocol, PetRegisterProtocol { }

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

extension PetRegisterUseCase: PetRegisterProtocol {
    func petRegister(data: PetRegister, success: @escaping (Bool) -> Void, failure: @escaping (Error) -> Void, completion: @escaping () -> Void) {

        if let idUser = Auth.auth().currentUser?.uid {

            let db = Firestore.firestore()
            let pets = db.collection(Endpoint.usersCollection.urlString).document(idUser).collection(Endpoint.petsCollection.urlString)
            do {
                let newPet = try pets.document().setData(from: data)
                success(true)
            } catch {
                failure(NetworkingServerErrors.internalServerError)
            }

        } else {
            failure(NetworkingClientErrors.requestInvalid)
            completion()
        }

    }
}
