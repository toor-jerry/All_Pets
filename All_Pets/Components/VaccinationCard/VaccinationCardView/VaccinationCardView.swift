//  VaccinationCardView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct VaccinationCardView: View {

    @StateObject var viewModel = VaccinationCardViewModel(useCase: VaccinationCardUseCase())
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                Loader()
            } else {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
        }
        .task {
            viewModel.getCards()
        }
    }
}

struct VaccinationCardViewPreviews: PreviewProvider {
    static var previews: some View {
        VaccinationCardView()
    }
}

