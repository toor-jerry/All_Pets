//  PetRegisterViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class PetRegisterViewModel: ObservableObject {

    @Published var isLoading: Bool = false
    @Published var types: [String: [String]] = [:]

    let useCase: PetRegisterUseCaseProtocol

    init(useCase: PetRegisterUseCaseProtocol) {
        self.useCase = useCase
    }

    func getPetsType() {
        isLoading = true
        useCase.getPetTypes(success: { types in
            self.types = types
        }, failure: { _ in

        }, completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        })
    }

    func petRegister(_ data: PetRegister, _ image: UIImage? = nil) {
        isLoading = true
        useCase.getPetIdCollection(success: { idDocument, idUser in
            self.useCase.petRegister( idUser,
                                      idDocument,
                                      data,
                                      success: { _ in

            }, failure: { _ in

            }, completion: {
                self.setTheardMain {
                    self.isLoading = false
                }
            })

            if let image = image {
                self.useCase.uploadImage("images/Ym9GsB7d7KcS7iKHJ6WuxYGkqDM2/pets/\(idDocument)/\(idDocument)",
                                         image,
                                         success: { urlPhotoString in

                }, failure: { _ in

                }, completion: {

                })
            }

        }, failure: { _ in
            self.setTheardMain {
                self.isLoading = false
            }
        })
    }
}
