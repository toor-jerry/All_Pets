//  HomeUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 18/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseStorage
import AllPetsNetworkProvider

protocol CiteProtocol: AnyObject {
    func getCites(success: @escaping (_ cites: [CiteModel]) -> Void,
                  failure: @escaping (Error) -> Void,
                  completion: @escaping () -> Void)
}

protocol HomeUseCaseProtocol: CiteProtocol { }

final class HomeUseCase: HomeUseCaseProtocol { }

extension HomeUseCase: CiteProtocol {

    func getCites(success: @escaping ([CiteModel]) -> Void,
                  failure: @escaping (Error) -> Void,
                  completion: @escaping () -> Void) {

        if let idUser = Auth.auth().currentUser?.uid {

            let db = Firestore.firestore()

            let citesCollection = db.collection(Endpoint.citesCollection.urlString).whereField("userId", isEqualTo: idUser)

            citesCollection.getDocuments { querySnapshot, error in

                if let error = error {
                    failure(error)
                } else {
                    var cards: [CiteModel] = []

                    for document in querySnapshot?.documents ?? [] {
                        do {
                            let card = try document.data(as: CiteModel.self)
                            cards.append(card)
                        } catch {
                            print("Errors: ", NetworkingClientErrors.decodingError)
                        }
                    }

                    success(cards)
                }

                completion()
            }
        } else {
            failure(NetworkingClientErrors.requestInvalid)
            completion()
        }
    }
}
