//  VeterianUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 31/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol VeterianUseCaseProtocol: OfficeProtocol { }

final class VeterianUseCaseUseCase: VeterianUseCaseProtocol { }

extension VeterianUseCaseUseCase: OfficeProtocol {
    
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
