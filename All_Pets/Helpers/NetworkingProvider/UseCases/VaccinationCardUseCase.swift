//  VaccinationCardUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

protocol VaccinationCardProtocol: AnyObject {
    func getVaccinationCard(success: @escaping (_ cards: [VaccinationCard]) -> Void,
                            failure: @escaping (Error) -> Void,
                            completion: @escaping () -> Void)
}

protocol VaccinationCardUseCaseProtocols: VaccinationCardProtocol { }

final class VaccinationCardUseCase: VaccinationCardUseCaseProtocols { }

extension VaccinationCardUseCase: VaccinationCardProtocol {
    
    func getVaccinationCard(success: @escaping ([VaccinationCard]) -> Void,
                            failure: @escaping (Error) -> Void,
                            completion: @escaping () -> Void) {
        
        if let idUser = Auth.auth().currentUser?.uid {
            
            let db = Firestore.firestore()
            
            let citesCollection = db.collection(Endpoint.citesCollection.urlString).whereField("userId", isEqualTo: idUser)
            
            citesCollection.getDocuments { querySnapshot, error in
                
                if let error = error {
                    failure(error)
                } else {
                    var cards: [VaccinationCard] = []
                    
                    for document in querySnapshot?.documents ?? [] {
                        do {
                            let card = try document.data(as: VaccinationCard.self)
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
