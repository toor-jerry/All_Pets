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
    @State var refreshView: Bool = false

    private let sizeImageButtons: CGFloat = 50

    var body: some View {
        NavigationStack {

            if viewModel.isLoading {
                Loader()
            } else {

                VStack {
                    Text("\(String.MsgHello) \(viewModel.user.name)!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 50)

                    Text(viewModel.msgHomeView ?? "")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.principal)
                        .padding(.top, 38)

                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button(action: {

                        }, label: {
                            VStack {
                                Image(systemName: "bolt.heart")
                                    .resizable()
                                    .foregroundColor(.green.opacity(0.5))
                                    .frame(width: sizeImageButtons, height: sizeImageButtons)

                                Spacer()

                                Text(String.MsgVaccinationCard)
                                    .foregroundColor(.black)
                            }
                        })
                        .font(.title3)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                        .background(.white)
                        .cornerRadius(8)
                        .modifier(shadowStyle1())

                        NavigationLink(destination: VaccinationCardView(),
                                       label: {
                            VStack {
                                Image(systemName: "newspaper")
                                    .resizable()
                                    .foregroundColor(.blue.opacity(0.5))
                                    .frame(width: sizeImageButtons, height: sizeImageButtons)

                                Spacer()

                                Text(String.MsgProceedings)
                                    .foregroundColor(.black)
                            }
                        })
                        .font(.title3)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                        .background(.white)
                        .cornerRadius(8)
                        .modifier(shadowStyle1())
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 90)
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
                    .padding(40)
                }
                .background(Color.background)
                .onAppear {
                    if refreshView {
                        refreshView = false
                        viewModel.getInitData()
                    }
                }
                .navigationDestination(isPresented: $showPetRegister, destination: {
                    PetRegisterView(showPetRegisterView: $refreshView)
                })
                .toolbar {
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
