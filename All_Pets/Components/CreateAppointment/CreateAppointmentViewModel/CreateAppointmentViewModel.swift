//  CreateAppointmentViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 22/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class CreateAppointmentViewModel: ObservableObject {
    
    let useCase: CreateAppoimentUseCaseProtocol
    
    @Published var isLoading: Bool = false
    
    init(useCase: CreateAppoimentUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func createAppoiment(appoiment: CiteModel,
                         completion: @escaping () -> Void) {
        isLoading = true
        useCase.createAppoiment(appoiment,
                                success: { },
                                failure: { _ in },
                                completion: {
            self.setTheardMain {
                self.isLoading = false
                completion()
            }
        })
    }
}
