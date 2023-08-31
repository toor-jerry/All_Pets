//  VaccinationCardView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct VaccinationCardView: View {

    @State var idPet: String
    @StateObject var viewModel = VaccinationCardViewModel(useCase: VaccinationCardUseCase())

    var body: some View {
        VStack {
            if viewModel.isLoading {
                Loader()
            } else {
                if !viewModel.cards.isEmpty {
                    Spacer()
                    List {
                        ForEach(viewModel.cards, id: \.vaccinationDate) { card in
                            VaccinationCardCell(card: card)
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .modifier(shadowStyle1())
                                .padding(.bottom, 18)
                                .padding(.horizontal, 8)
                        )
                        .listRowSeparator(.hidden)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .modifier(NavigationBarModifier())
        .background(Color.background)
        .task {
            viewModel.getCards(idPet)
        }
    }
}

struct VaccinationCardViewPreviews: PreviewProvider {
    static var previews: some View {
        VaccinationCardView(idPet: "")
    }
}
