//  HomeView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 17/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel = HomeViewModelViewModel(useCase: HomeUseCase())

    @State private var showingCredits = false
    @State private var showPetRegister: Bool = false

    var body: some View {
        VStack {

            NavigationStack {

                if viewModel.isLoading {
                    Loader()
                } else {
                    VStack {
                        Text("\(String.MsgHello) \(viewModel.user.name)!")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .navigationDestination(isPresented: $showPetRegister, destination: {
                        PetRegisterView()
                    })
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarLeading) {
                            if let pet = viewModel.petSelected {
                                Button(action: {
                                    showingCredits.toggle()
                                }, label: {

                                    HStack {
                                        if let imageUrl = viewModel.petSelected?.photoURL {
                                            AsyncImage(url: URL(string: imageUrl)) { image in
                                                image
                                                    .resizable()
                                                    .modifier(textProfileBackground())
                                            } placeholder: {
                                                Image(systemName: "photo.fill")
                                                    .resizable()
                                                    .modifier(textProfileBackground())
                                            }

                                        } else {

                                            Image(viewModel.petSelected?.pet ?? "photo.fill")
                                                .resizable()
                                                .modifier(textProfileBackground())
                                        }
                                        Text(pet.name ?? "")
                                        Image(systemName: "arrowtriangle.down.fill")
                                    }
                                })
                            } else {
                                Button(action: {
                                    showPetRegister.toggle()
                                }, label: {
                                    Text("Agregar mascota")
                                        .modifier(textStylePrincipal())
                                })
                                .modifier(buttonPrincipal())
                            }
                        }
                    })
                }

            }


        }.sheet(isPresented: $showingCredits) {
            VStack {
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
                .foregroundColor(.black)

                Spacer()
            }
            .presentationDetents([.medium, .large])
        }
        .onAppear {
            viewModel.getInitData()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
