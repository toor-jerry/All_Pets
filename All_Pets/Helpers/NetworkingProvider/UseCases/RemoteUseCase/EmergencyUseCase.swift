//  EmergencyUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 28/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import AllPetsNetworkProvider

protocol OfficeProtocol: AnyObject {
    func getOffices(success: @escaping (_ offices: [OfficeModel]) -> Void,
                    failure: @escaping (Error) -> Void,
                    completion: @escaping () -> Void)
}

protocol EmergencyUseCaseProtocol: OfficeProtocol { }

final class EmergencyUseCase: EmergencyUseCaseProtocol { }

extension EmergencyUseCase: OfficeProtocol {

    func getOffices(success: @escaping ([OfficeModel]) -> Void,
                    failure: @escaping (Error) -> Void,
                    completion: @escaping () -> Void) {

        let db = Firestore.firestore()

        let officeCollection = db.collection(Endpoint.officesCollection.urlString)

        officeCollection.getDocuments { querySnapshot, error in

            if let error = error {
                failure(error)
            } else {
                var offices: [OfficeModel] = []

                for document in querySnapshot?.documents ?? [] {
                    do {
                        let office = try document.data(as: OfficeModel.self)
                        offices.append(office)
                    } catch {
                        print("Errors: ", NetworkingClientErrors.decodingError, error)
                    }
                }

                success(offices)
            }

            completion()
        }
    }
}
