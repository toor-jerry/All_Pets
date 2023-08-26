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
                    List {
                        ForEach(viewModel.cards, id: \.vaccinationDate) { card in
                            VaccinationCardCell(card: card)
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .modifier(shadowStyle1())
                                .padding(.bottom, 18)
                                .padding(.horizontal, 10)
                        )
                        .listRowSeparator(.hidden)
                    }
                }
            }
        }
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

struct VaccinationCardCell: View {
    
    var card: VaccinationCardModel
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Fecha")
                    
                    Text(card.getDateWithFormat())
                        .font(.title3)
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("CP Médico")
                    
                    Text(card.professionalLicense)
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }
            
            VStack {
                Text(card.status.capitalized)
                    .foregroundColor(card.getStatus()?.getTextColor())
                    .fontWeight(.bold)
                    .padding(10)
                    .background(card.getStatus()?.getBackgroundColor())
                    .modifier(CornerRadiusStyle(radius: 18, corners: [.bottomLeft, .topRight]))
                
                Spacer()
            }
            
        }
        .frame(height: 100)
    }
}
