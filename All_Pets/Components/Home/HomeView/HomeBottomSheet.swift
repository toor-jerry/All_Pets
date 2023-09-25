//  HomeBottomSheet.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 31/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct HomeBottomSheet: View {

    @StateObject var viewModel: HomeViewModelViewModel
    @EnvironmentObject var sessionInfo: SessionInfo
    @Binding var showingCredits: Bool
    @Binding var showPetRegister: Bool

    var body: some View {
        VStack {
            VStack {

                if !sessionInfo.pets.isEmpty {
                    List {
                        ForEach(sessionInfo.pets, id: \.id) { pet in
                            HomeBottomSheetCell(pet: pet, isChecked: isPetSelected(pet.id))
                                .onTapGesture {
                                    if !isPetSelected(pet.id) {
                                        sessionInfo.petSelected = pet
                                    }
                                }
                                .swipeActions(edge: .leading) {
                                    Button(action: { viewModel.removePet(pet, pets: sessionInfo.pets, completion: { pets, petSelected in
                                        self.sessionInfo.pets = pets
                                        self.sessionInfo.petSelected = petSelected
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

                        if sessionInfo.pets.count < 4 {
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
        return id == sessionInfo.petSelected?.id ?? ""
    }
}
