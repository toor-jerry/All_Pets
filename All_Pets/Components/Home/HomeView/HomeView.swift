//  HomeView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 17/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var sessionInfo: SessionInfo
    @StateObject var viewModel = HomeViewModelViewModel(useCase: HomeUseCase())

    @State var showingCredits = false
    @State var showPetRegister: Bool = false
    @State var refreshView: Bool = false

    private let sizeImageButtons: CGFloat = 50

    var body: some View {
        NavigationStack {

            if viewModel.isLoading {
                Loader()
            } else {

                ScrollView {
                    Text("\(String.MsgHello) \(viewModel.user.name)!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 50)
                        .foregroundColor(.black)

                    Text(viewModel.getHomeMsg(petSelected: sessionInfo.petSelected))
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.principal)
                        .padding(.top, 38)

                    Spacer()

                    HStack {

                        NavigationLink(destination: VaccinationCardView(idPet: sessionInfo.petSelected?.id ?? ""),
                                       label: {
                            VStack {
                                Image(systemName: "bolt.heart")
                                    .resizable()
                                    .foregroundColor(.green.opacity(0.5))
                                    .frame(width: sizeImageButtons, height: sizeImageButtons)

                                Spacer()


                                HStack {
                                    Spacer()
                                    Text(String.MsgVaccinationCard)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                            }
                        })
                        .font(.title3)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                        .background(.white)
                        .cornerRadius(8)
                        .modifier(shadowStyle1())

                        Spacer()

                        NavigationLink(destination: EmptyView(),
                                       label: {
                            VStack {
                                Image(systemName: "newspaper")
                                    .resizable()
                                    .foregroundColor(.blue.opacity(0.5))
                                    .frame(width: sizeImageButtons, height: sizeImageButtons)

                                Spacer()

                                HStack {
                                    Spacer()
                                    Text(String.MsgProceedings)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                            }
                        })
                        .font(.title3)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                        .background(.white)
                        .cornerRadius(8)
                        .modifier(shadowStyle1())
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 20)


                    Button(action: {

                    }, label: {
                        HStack {
                            Image(systemName: "note.text")
                                .resizable()
                                .foregroundColor(.purple.opacity(0.5))
                                .frame(width: sizeImageButtons, height: sizeImageButtons)
                            Spacer()
                            Text(String.MsgRequestDigitalProof)
                                .foregroundColor(.black)
                        }
                    })
                    .font(.title3)
                    .padding(EdgeInsets(top: 27, leading: 20, bottom: 27, trailing: 20))
                    .background(.white)
                    .cornerRadius(8)
                    .modifier(shadowStyle1())
                }
                .padding(.horizontal, 30)
                .background(Color.background)
                .onAppear {
                    if refreshView {
                        refreshView = false
                        viewModel.getInitData(completion: { pets, petSelected in
                            self.sessionInfo.pets = pets
                            if let pet = self.sessionInfo.petSelected {
                                self.sessionInfo.petSelected = pet
                            } else {
                                self.sessionInfo.petSelected = petSelected
                            }
                        })
                    }
                }
                .navigationDestination(isPresented: $showPetRegister, destination: {
                    PetRegisterView(showPetRegisterView: $refreshView)
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if let pet = sessionInfo.petSelected {
                            Button(action: {
                                showingCredits.toggle()
                            }, label: {

                                HStack {
                                    if let imageUrl = sessionInfo.petSelected?.photoURL {
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

                                        Image(sessionInfo.petSelected?.pet ?? "photo.fill")
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
                                Text(String.MsgAddNewPet)
                                    .fontWeight(.bold)
                                    .padding(5)
                            })
                            .foregroundColor(.white)
                            .background(Color.principal)
                            .cornerRadius(50)
                            .modifier(shadowStyle1())
                        }
                    }
                }
            }

        }
        .sheet(isPresented: $showingCredits) {
            HomeBottomSheet(viewModel: viewModel, showingCredits: $showingCredits, showPetRegister: $showPetRegister)
        }
        .onAppear {
            viewModel.getInitData(completion: { pets, petSelected in
                self.sessionInfo.pets = pets
                if let pet = self.sessionInfo.petSelected {
                    self.sessionInfo.petSelected = pet
                } else {
                    self.sessionInfo.petSelected = petSelected
                }
            })
        }
    }
}

#Preview {
    HomeView()
}
