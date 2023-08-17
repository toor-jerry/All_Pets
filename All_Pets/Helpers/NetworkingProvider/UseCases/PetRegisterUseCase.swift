//  PetRegisterUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol PetRegisterProtocol: AnyObject {
    func petRegister(_ idUser: String,
                     _ idColletion: String,
                     _ data: PetRegister,
                     success: @escaping (_ registered: Bool) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void)
}

protocol PetIdCollectionProtocol: AnyObject {
    func getPetIdCollection(success: @escaping (_ idDocument: String,
                                                _ idUser: String) -> Void,
                            failure: @escaping (Error) -> Void)
}

protocol PetTypesProtocol: AnyObject {
    func getPetTypes(success: @escaping (_ types: [String: [String]]) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void)
}

protocol uploadImageProtocol: AnyObject {
    func uploadImage(_ basePath: String,
                     _ image: UIImage,
                     success: @escaping (_ urlPhotoString: String) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void)
}

protocol PetRegisterUseCaseProtocol: PetTypesProtocol, PetRegisterProtocol, uploadImageProtocol, PetIdCollectionProtocol { }

final class PetRegisterUseCase: PetRegisterUseCaseProtocol { }

extension PetRegisterUseCase: PetTypesProtocol {

    func getPetTypes(success: @escaping (_ types: [String: [String]]) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void) {

        let db = Firestore.firestore()
        let typePets = db.collection(Endpoint.typePets.urlString).document(Constants.documentIdPetTypes)

        typePets.getDocument { document, error in

            if let _ = error {
                failure(NetworkingServerErrors.dataNotFound)
            } else if let document = document, document.exists {
                if let data = document.data() as? [String: [String]] {
                    success(data)
                } else {
                    failure(NetworkingServerErrors.response)
                }
            }

            completion()
        }
    }
}

extension PetRegisterUseCase: PetIdCollectionProtocol {

    func getPetIdCollection(success: @escaping (String, String) -> Void,
                            failure: @escaping (Error) -> Void) {

        if let idUser = Auth.auth().currentUser?.uid {

            let db = Firestore.firestore()
            let pets = db.collection(Endpoint.usersCollection.urlString).document(idUser).collection(Endpoint.petsCollection.urlString)

            let newPetDocument = pets.document()
            let newPetId = newPetDocument.documentID

            success(newPetId, idUser)
        } else {
            failure(NetworkingClientErrors.requestInvalid)
        }
    }
}

extension PetRegisterUseCase: PetRegisterProtocol {

    func petRegister(_ idUser: String,
                     _ idCollection: String,
                     _ data: PetRegister,
                     success: @escaping (_ registered: Bool) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void) {

        let db = Firestore.firestore()
        let pets = db.collection(Endpoint.usersCollection.urlString).document(idUser).collection(Endpoint.petsCollection.urlString)
        do {
            let _ = try pets.document(idCollection).setData(from: data)

            success(true)
        } catch {
            failure(NetworkingServerErrors.internalServerError)
        }

        completion()
    }
}

extension PetRegisterUseCase: uploadImageProtocol {

    func uploadImage(_ basePath: String,
                     _ image: UIImage,
                     success: @escaping (_ urlPhotoString: String) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void) {

        var imageExtension: String = ""
        var imageDataTemp: Data? = nil

        if let imageData = image.jpegData(compressionQuality: Constants.compressionQualityImageForFirebase) {
            imageExtension = ".jpeg"
            imageDataTemp = imageData
        } else if let imageData = image.pngData() {
            imageExtension = ".png"
            imageDataTemp = imageData
        }
        
        if imageExtension.isEmpty {
            failure(NetworkingClientErrors.requestInvalid)
            completion()
        } else if let imageData = imageDataTemp {
            
            uploadImage(basePath: basePath + imageExtension,
                        imageData: imageData,
                        success: success,
                        failure: failure,
                        completion: completion)
        }
    }

    private func uploadImage(basePath: String,
                             imageData: Data,
                             success: @escaping (_ urlPhotoString: String) -> Void,
                             failure: @escaping (Error) -> Void,
                             completion: @escaping () -> Void) {

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child(basePath)

        _ = imageRef.putData(imageData, metadata: nil) { metadata, error in

            if let _ = error {
                failure(NetworkingServerErrors.internalServerError)
            } else {

                imageRef.downloadURL { url, error in

                    if let _ = error {
                        failure(NetworkingServerErrors.dataNotFound)
                    } else if let url = url {
                        success(url.absoluteString)
                    }
                }
            }

            completion()
        }
    }
}
