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
    @State private var image = UIImage()
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
                            Button(action: {
                                showingCredits.toggle()
                            }, label: {
                                HStack {
                                    Image(uiImage: self.image)
                                        .resizable()
                                        .cornerRadius(50)
                                        .padding(.all, 4)
                                        .frame(width: 40, height: 40)
                                        .background(Color.black.opacity(0.2))
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                    Text("Nombre mascota")
                                    Image(systemName: "arrowtriangle.down.fill")
                                }
                            })
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
