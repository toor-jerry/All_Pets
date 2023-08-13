//  SignUpUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

protocol SignUpProtocol: AnyObject {
    func signUp(data: SignUpModel,
                success: @escaping (_ idUser: String) -> Void,
                failure: @escaping (Error) -> Void,
                completion: @escaping () -> Void)
}

protocol SignUpUseCaseProtocol: SignUpProtocol { }

final class SignUpUseCase: SignUpUseCaseProtocol { }

extension SignUpUseCase: SignUpProtocol {

    func signUp(data: SignUpModel,
                success: @escaping (_ idUser: String) -> Void,
                failure: @escaping (Error) -> Void,
                completion: @escaping () -> Void) {

        Auth.auth().createUser(withEmail: data.email,
                               password: data.password) { (result, errorResponse) in

            if let _ = errorResponse {
                failure(NetworkingServerErrors.response)
            } else if let idUser = result?.user.uid as? String {
                self.addUserToFirestore(idUser,
                                   data: data,
                                        success: {
                    success(idUser)
                }, failure: { error in
                    failure(error)
                })
            } else {
                failure(NetworkingServerErrors.dataNotFound)
            }

            completion()
        }
    }

    private func addUserToFirestore(_ idUser: String,
                                    data: SignUpModel,
                                    success: @escaping () -> Void,
                                    failure: @escaping (Error) -> Void) {

        let db = Firestore.firestore()
        let usersCollection = db.collection(Endpoint.usersCollection.urlString).document(idUser)

        do {
            try usersCollection.setData(from: data)
            success()
        } catch {
            failure(NetworkingServerErrors.internalServerError)
        }
    }
}
