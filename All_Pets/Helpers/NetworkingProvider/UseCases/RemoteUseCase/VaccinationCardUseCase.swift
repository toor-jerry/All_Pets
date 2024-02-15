//  VaccinationCardUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

protocol GetVaccinationCardProtocol: AnyObject {
    func getVaccinationCard(_ idPet: String,
                            success: @escaping (_ vaccinationCard: [VaccinationCardModel]) -> Void,
                            failure: @escaping (Error) -> Void,
                            completion: @escaping () -> Void)
}

protocol VaccinationCardProtocols: GetVaccinationCardProtocol { }

final class VaccinationCardUseCase: VaccinationCardProtocols { }

extension VaccinationCardUseCase: GetVaccinationCardProtocol {

    func getVaccinationCard(_ idPet: String,
                            success: @escaping ([VaccinationCardModel]) -> Void,
                            failure: @escaping (Error) -> Void,
                            completion: @escaping () -> Void) {

        if let idUser = Auth.auth().currentUser?.uid {

            let db = Firestore.firestore()

            let vaccinationCardCollection = db.collection(Endpoint.usersCollection.urlString)
                .document(idUser)
                .collection(Endpoint.petsCollection.urlString).document(idPet).collection(Endpoint.vaccinationCard.urlString)

            vaccinationCardCollection.getDocuments { querySnapshot, error in

                if let error = error {
                    failure(error)
                } else {
                    var cards: [VaccinationCardModel] = []

                    for document in querySnapshot?.documents ?? [] {
                        do {
                            let card = try document.data(as: VaccinationCardModel.self)
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
