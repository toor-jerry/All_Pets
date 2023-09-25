//  HomeBottomSheet.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 31/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct HomeBottomSheet: View {

    @StateObject var viewModel: HomeViewModelViewModel
    @Binding var pets: [Pet]
    @Binding var petSelected: Pet?
    @Binding var showingCredits: Bool
    @Binding var showPetRegister: Bool

    var body: some View {
        VStack {
            VStack {

                if !pets.isEmpty {
                    List {
                        ForEach(pets, id: \.id) { pet in
                            HomeBottomSheetCell(pet: pet, isChecked: isPetSelected(pet.id))
                                .onTapGesture {
                                    if !isPetSelected(pet.id) {
                                        petSelected = pet
                                    }
                                }
                                .swipeActions(edge: .leading) {
                                    Button(action: { viewModel.removePet(pet, pets: pets, completion: { pets, petSelected in
                                        self.pets = pets
                                        self.petSelected = petSelected
                                    })
                                    }, label: {
                                        Image(systemName: "trash")
                                    })
                                    .tint(.red)
                                }
                        }
                        .listRowBackground(
                            Rectangle()
                                .fill(.clear)
                        )
                        .listRowSeparator(.hidden)

                        if pets.count < 4 {
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
                } else {
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
                    .padding(25)
                }

                Spacer()
            }
        }
        .presentationDetents([.medium, .large])
        .background(Color.background)
        .foregroundColor(.black)
    }

    private func isPetSelected(_ id: String) -> Bool {
        return id == petSelected?.id ?? ""
    }
}
