//  HomeViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 17/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class HomeViewModelViewModel: ObservableObject {

    let useCase: HomeUseCaseProtocol

    @Published var isLoading: Bool = false
    @Published var user: User = User()
    @Published var pets: [Pet] = []

    private var callService: Int = .zero
    
    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }

    func getInitData() {

        getUser()
        getPets()
    }

    private func getUser() {

        startLoading()
        useCase.getUser(success: { user in
            self.user = user
        }, failure: { _ in

        }, completion: {
            self.stopLoading()
        })
    }

    private func getPets() {

        startLoading()

        useCase.getPets(success: { pets in
            self.pets = pets
        }, failure: { _ in

        }, completion: {
            self.stopLoading()
        })
    }

    private func startLoading() {
        isLoading = true
        callService += 1
    }

    private func stopLoading() {
        callService -= 1

        if callService <= .zero {
            setTheardMain {
                self.isLoading = false
            }

            callService = .zero
        }
    }
}
