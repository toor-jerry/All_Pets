//  HomeBottomSheet.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 31/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct HomeBottomSheet: View {

    @StateObject var viewModel: HomeViewModelViewModel
    @Binding var showingCredits: Bool
    @Binding var showPetRegister: Bool

    var body: some View {
        VStack {
            VStack {

                if !viewModel.pets.isEmpty {
                    List {
                        ForEach(viewModel.pets, id: \.id) { pet in
                            HomeBottomSheetCell(pet: pet, isChecked: isPetSelected(pet.id))
                                .onTapGesture {
                                    if !isPetSelected(pet.id) {
                                        viewModel.petSelected = pet
                                    }
                                }
                        }
                        .listRowBackground(
                            Rectangle()
                                .fill(.clear)
                        )
                        .listRowSeparator(.hidden)

                        if viewModel.pets.count < 4 {
                            Section(content: { }, footer: {
                                Button(action: {
                                    showingCredits.toggle()
                                    showPetRegister.toggle()
                                }, label: {
                                    HStack {
                                        Image(systemName: "plus")
                                            .fontWeight(.bold)
                                            .font(.title)
                                        Text(String.MsgAddPet)
                                            .font(.title3)
                                        Spacer()
                                    }
                                })
                            })
                        }
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                }

                Spacer()
            }
        }
        .presentationDetents([.medium, .large])
        .background(Color.background)
        .foregroundColor(.black)
    }

    private func isPetSelected(_ id: String) -> Bool {
        return id == viewModel.petSelected?.id ?? ""
    }
}
