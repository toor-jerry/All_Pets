//  CreateAppoimentUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 07/10/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import AllPetsNetworkProvider

protocol CreateAppoimentProtocol: AnyObject {
    func createAppoiment(_ data: CiteModel,
                         success: @escaping () -> Void,
                         failure: @escaping (Error) -> Void,
                         completion: @escaping () -> Void)
}

protocol CreateAppoimentUseCaseProtocol: CreateAppoimentProtocol { }

final class CreateAppoimentUseCase: CreateAppoimentUseCaseProtocol { }

extension CreateAppoimentUseCase: CreateAppoimentProtocol {

    func createAppoiment(_ data: CiteModel,
                         success: @escaping () -> Void,
                         failure: @escaping (Error) -> Void,
                         completion: @escaping () -> Void) {

        if let idUser = Auth.auth().currentUser?.uid {

            let db = Firestore.firestore()
            let cites = db.collection(Endpoint.citesCollection.urlString)

            do {
                var dataTemp: CiteModel = data
                dataTemp.userId = idUser
                _ = try cites.addDocument(from: dataTemp)
                success()
            } catch {
                failure(NetworkingServerErrors.internalServerError)
            }
            completion()
        } else {
            failure(NetworkingClientErrors.requestInvalid)
            completion()
        }
    }
}
