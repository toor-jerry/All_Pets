//  ExploreViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/10/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class ExploreViewModelViewModel: ObservableObject {

    let useCase: ExploreViewModelUseCase

    init(useCase: ExploreViewModelUseCase) {
        self.useCase = useCase
    }

//    func auth() {
//        isLoading = true
//        useCase.preAuth { isLoggedIn in
//            self.isLoggedIn = isLoggedIn
//        } error: { _ in
//            self.isLoggedIn = false
//        } completion: {
//            self.setTheardMain {
//                self.isLoading = false
//            }
//        }
    }
}
