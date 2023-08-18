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

        self.useCase.petRegister(data.getData(),
                                 success: { idCollection in

            if let image = image, !image.isEqual(UIImage()) {
                self.uploadImage(idCollection, image, data.getData())
            } else {
                self.stopLoading()
            }

        }, failure: { _ in
            self.stopLoading()
        }, completion: { })
    }

    func uploadImage(_ idCollection: String, _ image: UIImage, _ data: PetRegister) {

        startLoading()

        self.useCase.uploadImage(idCollection,
                                 image,
                                 success: { urlPhoto in

            self.updateDataRegiter(data.getData(urlPhoto))

        }, failure: { _ in
            self.stopLoading()
        }, completion: { })
    }

    func updateDataRegiter(_ data: PetRegister) {

        startLoading()

        self.useCase.petRegister(data,
                                 success: { _ in },
                                 failure: { _ in },
                                 completion: {
            self.stopLoading()
        })
    }

    private func stopLoading() {
        setTheardMain {
            self.isLoading = false
        }
    }

    private func startLoading() {
        if !isLoading {
            isLoading = true
        }
    }
}
