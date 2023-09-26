//  SessionInfoUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseStorage

protocol GetUserProtocol: AnyObject {
    func getUser(success: @escaping (_ userData: User) -> Void,
                 failure: @escaping (Error) -> Void,
                 completion: @escaping () -> Void)
}

protocol DeletePetProtocol: AnyObject {
    func deletePet(pet: Pet,
                   success: @escaping () -> Void,
                   failure: @escaping (Error) -> Void,
                   completion: @escaping () -> Void)
}

protocol SessionInfoProtocols: GetUserProtocol, DeletePetProtocol { }

final class SessionInfoUseCase: SessionInfoProtocols { }

extension SessionInfoUseCase: GetUserProtocol {

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

extension SessionInfoUseCase: DeletePetProtocol {

    func deletePet(pet: Pet,
                   success: @escaping () -> Void,
                   failure: @escaping (Error) -> Void,
                   completion: @escaping () -> Void) {

        if let imageURL = pet.photoURL {
            deletePetImage(imageURL, success: {
                print("Data2 La imagen se eliminó con éxito")
            }, failure: { error in
                print("Data2 Hubo un error al eliminar la imagen")
            }, completion: { })
        }

        deletePetCites(pet, success: {
            print("Data2 Citas eliminadas con éxito")
        }, failure: { _ in
            print("Data2 Hubo un error al eliminar la imagen")
        }, completion: { })

        if let idUser = Auth.auth().currentUser?.uid {

            let db = Firestore.firestore()

            let petDocRef = db.collection(Endpoint.usersCollection.urlString)
                .document(idUser)
                .collection(Endpoint.petsCollection.urlString)
                .document(pet.id)

            petDocRef.delete { error in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            }

        } else {
            failure(NetworkingClientErrors.requestInvalid)
        }

        completion()
    }

    func deletePetImage(_ imageURL: String,
                        success: @escaping () -> Void,
                        failure: @escaping (Error) -> Void,
                        completion: @escaping () -> Void) {

        let storageRef = Storage.storage().reference(forURL: imageURL)

        storageRef.delete { error in
            if let error = error {
                failure(error)
            } else {
                success()
            }
            completion()
        }
    }

    func deletePetCites(_ pet: Pet,
                        success: @escaping () -> Void,
                        failure: @escaping (Error) -> Void,
                        completion: @escaping () -> Void) {

        guard let idUser = Auth.auth().currentUser?.uid else {
            failure(NetworkingClientErrors.requestInvalid)
            completion()
            return
        }

        let db = Firestore.firestore()
        let citesCollection = db.collection(Endpoint.citesCollection.urlString)

        citesCollection.whereField("userId", isEqualTo: idUser)
            .whereField("patient", isEqualTo: pet.id)
            .getDocuments { querySnapshot, error in

                if let error = error {
                    failure(error)
                    completion()
                    return
                }

                let batch = db.batch()

                for document in querySnapshot?.documents ?? [] {
                    let citeRef = citesCollection.document(document.documentID)
                    batch.deleteDocument(citeRef)
                }

                batch.commit { error in
                    if let error = error {
                        failure(error)
                    } else {
                        success()
                    }
                    completion()
                }
            }
    }
}
