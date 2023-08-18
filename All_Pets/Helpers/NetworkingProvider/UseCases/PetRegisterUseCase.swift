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

enum ImageType: String {
    case png
    case jpeg
    case none
}

protocol PetRegisterProtocol: AnyObject {
    func petRegister(_ data: PetRegister,
                     success: @escaping (_ idColletion: String) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void)
}

protocol PetTypesProtocol: AnyObject {
    func getPetTypes(success: @escaping (_ types: [String: [String]]) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void)
}

protocol UploadImageProtocol: AnyObject {
    func uploadImage(_ idColletion: String,
                     _ image: UIImage,
                     success: @escaping (_ urlPhotoString: String) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void)
}

protocol PetRegisterUseCaseProtocol: PetTypesProtocol, PetRegisterProtocol, UploadImageProtocol { }

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

extension PetRegisterUseCase: PetRegisterProtocol {
    
    func petRegister(_ data: PetRegister,
                     success: @escaping (_ idColletion: String) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void) {
        
        if let idUser = Auth.auth().currentUser?.uid {
            
            let db = Firestore.firestore()
            let pets = db.collection(Endpoint.usersCollection.urlString).document(idUser).collection(Endpoint.petsCollection.urlString)
            
            do {
                let newPet = try pets.addDocument(from: data)
                
                success(newPet.documentID)
                
            } catch {
                failure(NetworkingServerErrors.internalServerError)
            }
            completion()
        } else {
            failure(NetworkingClientErrors.requestInvalid)
            completion()
        }
    }
}

extension PetRegisterUseCase: UploadImageProtocol {
    
    func uploadImage(_ idColletion: String,
                     _ image: UIImage,
                     success: @escaping (String) -> Void,
                     failure: @escaping (Error) -> Void,
                     completion: @escaping () -> Void) {
        
        var imageType: ImageType = .none
        var imageDataTemp: Data? = nil
        
        if let imageData = image.jpegData(compressionQuality: Constants.compressionQualityImageForFirebase) {
            
            imageType = .jpeg
            imageDataTemp = imageData
        } else if let imageData = image.pngData() {
            
            imageType = .png
            imageDataTemp = imageData
        }
        
        if let imageDataTemp = imageDataTemp, imageType != .none {
            
            let storageRef = Storage.storage().reference()
            let imageRef = storageRef.child(Endpoint.imagePets(idColletion).urlString)
            
            let metadata = StorageMetadata()
            metadata.contentType = "\(Constants.contentTypeMediaImage)/\(imageType.rawValue)"
            
            _ = imageRef.putData(imageDataTemp, metadata: metadata) { metadata, error in
                
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
}
