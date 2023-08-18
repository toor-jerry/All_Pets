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

protocol HomeUseCaseProtocol: GetUserProtocol { }

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
