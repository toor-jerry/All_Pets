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

protocol GetPetsProtocol: AnyObject {
    func getPets(success: @escaping (_ pets: [Pet]) -> Void,
                 failure: @escaping (Error) -> Void,
                 completion: @escaping () -> Void)
}

protocol CiteProtocol: AnyObject {
    func getCites(success: @escaping (_ cites: [CiteModel]) -> Void,
                  failure: @escaping (Error) -> Void,
                  completion: @escaping () -> Void)
}

protocol HomeUseCaseProtocol: GetPetsProtocol, CiteProtocol { }

final class HomeUseCase: HomeUseCaseProtocol { }

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
