//  VaccinationCardView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import AllPetsCommons

struct VaccinationCardView: View {

    @State var idPet: String
    @StateObject var viewModel = VaccinationCardViewModel(useCase: VaccinationCardUseCase())

    var body: some View {
        VStack {
            if viewModel.isLoading {
                Loader()
            } else {
                if !viewModel.cards.isEmpty {
                    List {
                        ForEach(viewModel.cards, id: \.vaccinationDate) { card in
                            VaccinationCardCell(card: card)
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .modifier(GenShadowStyle())
                                .padding(.bottom, 18)
                                .padding(.horizontal, 8)
                        )
                        .listRowSeparator(.hidden)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .modifier(GenNavigationBar())
        .background(Color.backgroundPrincipal)
        .task {
            viewModel.getCards(idPet)
        }
    }
}

#Preview {
    VaccinationCardView(idPet: "")
}
