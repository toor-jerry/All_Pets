//  ExploreUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/10/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import AllPetsNetworkProvider

protocol BusinessProtocol: AnyObject {
    func getBusiness(success: @escaping (_ business: [BusinessModel]) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void)
}

protocol ExploreUseCaseProtocol: ExploreUseCase { }

final class ExploreUseCase: ExploreUseCaseProtocol { }

extension ExploreUseCase: BusinessProtocol {

    func getBusiness(success: @escaping ([BusinessModel]) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void) {

        let db = Firestore.firestore()

        let businessCollection = db.collection(Endpoint.businessCollection.urlString)

        businessCollection.getDocuments { querySnapshot, error in

            if let error = error {
                failure(error)
            } else {
                var business: [BusinessModel] = []

                for document in querySnapshot?.documents ?? [] {
                    do {
                        let businessObj = try document.data(as: BusinessModel.self)
                        business.append(businessObj)
                    } catch {
                        print("Errors: ", NetworkingClientErrors.decodingError, error)
                    }
                }

                success(business)
            }

            completion()
        }
    }
}
