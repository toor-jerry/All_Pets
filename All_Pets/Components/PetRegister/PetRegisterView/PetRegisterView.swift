//  PetRegisterView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

enum PetType: String {
    case dog
    case cat
    case bird
    case fish
}

struct PetRegisterView: View {

    @StateObject var viewModel = PetRegisterViewModel(useCase: PetRegisterUseCase())

    @State var petTypeSelected: String = .MsgSelectTypePet
    @State var petChanged: Bool = false

    @State private var selectedAnimal: PetType = .dog
    @State private var selectedDate = Date()
    @State private var name: String = ""
    @State private var image = UIImage()
    @State private var showUploadPhoto = false

    var body: some View {

        NavigationStack {
            if viewModel.isLoading {
                Loader()
            } else {
                ScrollView {
                    VStack(spacing: 20) {

                        Text(String.MsgTitlePetRegister)
                            .font(.title2)
                            .fontWeight(.bold)

                        VStack {
                            HStack {
                                AnimalIconView(selectedAnimal: $selectedAnimal, petChanged: $petChanged, pet: .dog)

                                Spacer()
                                AnimalIconView(selectedAnimal: $selectedAnimal, petChanged: $petChanged, pet: .cat)
                            }

                            HStack {
                                AnimalIconView(selectedAnimal: $selectedAnimal, petChanged: $petChanged, pet: .bird)

                                Spacer()
                                AnimalIconView(selectedAnimal: $selectedAnimal, petChanged: $petChanged, pet: .fish)
                            }
                        }

                        NavigationLink(destination: ListSearch(itemSelected: $petTypeSelected, list: viewModel.types[selectedAnimal.rawValue] ?? []), label: {
                            HStack {
                                Text(petTypeSelected.isEmpty || petChanged ? String.MsgSelectTypePet : petTypeSelected)
                                Spacer()
                                Image(systemName: "arrowtriangle.down.fill")
                            }
                        })
                        .foregroundColor(.black)
                        .onAppear {
                            petChanged = false
                        }

                        Divider()
                        DatePicker(String.MsgDateBirthDay, selection: $selectedDate, displayedComponents: .date)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 1)
                            )

                        TextField(String.MsgName, text: $name)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 1)
                            )

                        Button(action: {
                            showUploadPhoto = true
                        }, label: {
                            Text(String.MsgUploadProfilePhoto)
                                .fontWeight(.bold)
                                .foregroundColor(Color.principal)
                        })


                        Button(action: {
                            viewModel.petRegister(PetRegister(name: name,
                                                              petType: petTypeSelected,
                                                              birthDate: selectedDate,
                                                              pet: selectedAnimal.rawValue), self.image)
                        }, label: {
                            Text(String.MsgAdd)
                                .modifier(textStylePrincipal())
                        })
                        .modifier(buttonPrincipal())
                    }
                    .padding(.horizontal, 60)
                    .padding([.top, .bottom], 20)
                    .background(Color.background)
                }
            }
        }
        .onAppear {
            viewModel.getPetsType()
        }
        .sheet(isPresented: $showUploadPhoto) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
}

struct AnimalIconView: View {
    @Binding var selectedAnimal: PetType
    @Binding var petChanged: Bool
    var pet: PetType
    
    var body: some View {
        VStack {
            Image(pet.rawValue)
                .font(.system(size: 100))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.principal, lineWidth: isSelected(for: pet) ? 4 : .zero)
                )
                .onTapGesture {
                    if pet != selectedAnimal {
                        petChanged = true
                    }
                    selectedAnimal = pet
                }
            
            Text(String.MsgSelected)
                .font(.headline)
                .foregroundColor(isSelected(for: pet) ? Color.principal : .clear)
        }
    }
    
    func isSelected(for animal: PetType) -> Bool {
        return selectedAnimal == animal
    }
}

struct PetRegisterViewPreviews: PreviewProvider {
    static var previews: some View {
        PetRegisterView()
    }
}
