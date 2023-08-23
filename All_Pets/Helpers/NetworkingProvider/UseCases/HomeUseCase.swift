//  HomeUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 18/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

protocol GetUserProtocol: AnyObject {
    func getUser(success: @escaping (_ userData: User) -> Void,
                 failure: @escaping (Error) -> Void,
                 completion: @escaping () -> Void)
}

protocol GetPetsProtocol: AnyObject {
    func getPets(success: @escaping (_ pets: [Pet]) -> Void,
                 failure: @escaping (Error) -> Void,
                 completion: @escaping () -> Void)
}

protocol GetVaccinationCardProtocol: AnyObject {
    func getVaccinationCard(_ idPet: String,
                            success: @escaping (_ vaccinationCard: [VaccinationCardModel]) -> Void,
                            failure: @escaping (Error) -> Void,
                            completion: @escaping () -> Void)
}

protocol HomeUseCaseProtocol: GetUserProtocol, GetPetsProtocol, GetVaccinationCardProtocol { }

final class HomeUseCase: HomeUseCaseProtocol { }

extension HomeUseCase: GetUserProtocol {

    func getUser(success: @escaping (User) -> Void,
                 failure: @escaping (Error) -> Void,
                 completion: @escaping () -> Void) {

        if let idUser = Auth.auth().currentUser?.uid {

            let db = Firestore.firestore()
            let userRef = db.collection(Endpoint.usersCollection.urlString).document(idUser)

            userRef.getDocument { document, error in

                if let _ = error {
                    failure(NetworkingServerErrors.unknownError)
                } else if let document = document, document.exists {

                    do {
                        let user = try document.data(as: User.self)
                        success(user)
                    } catch {
                        failure(NetworkingClientErrors.decodingError)
                    }
                    
                } else {
                    failure(NetworkingServerErrors.dataNotFound)
                }

                completion()
            }
        } else {
            failure(NetworkingClientErrors.requestInvalid)
            completion()
        }
    }
}

extension HomeUseCase: GetPetsProtocol {

    func getPets(success: @escaping ([Pet]) -> Void,
                 failure: @escaping (Error) -> Void,
                 completion: @escaping () -> Void) {

        if let idUser = Auth.auth().currentUser?.uid {

            let db = Firestore.firestore()

            let petsCollection = db.collection(Endpoint.usersCollection.urlString)
                .document(idUser)
                .collection(Endpoint.petsCollection.urlString)

            petsCollection.getDocuments { querySnapshot, error in

                if let error = error {
                    failure(error)
                } else {
                    var pets: [Pet] = []

                    for document in querySnapshot?.documents ?? [] {
                        do {
                            let pet = try document.data(as: Pet.self)
                            pets.append(pet)
                        } catch {
                            print("Errors: ", NetworkingClientErrors.decodingError)
                        }
                    }

                    success(pets)
                }

                completion()
            }
        } else {
            failure(NetworkingClientErrors.requestInvalid)
            completion()
        }
    }
}


extension HomeUseCase: GetVaccinationCardProtocol {

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
