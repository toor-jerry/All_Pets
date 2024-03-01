//  PetRegisterView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import AllPetsCommons

struct PetRegisterView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @StateObject var viewModel = PetRegisterViewModel(useCase: PetRegisterUseCase())
    
    @State var petTypeSelected: String = String(localized: "MsgSelectTypePet")
    @State var petChanged: Bool = false

    @State private var selectedAnimal: PetType = .dog
    @State private var selectedDate = Date()
    @State private var name: String = ""
    @State private var image = UIImage()
    @State private var showUploadPhoto = false
    @Binding var showPetRegisterView: Bool

    var body: some View {
        NavigationStack {
            if viewModel.closeView {
                Loader()
                    .task {
                        presentationMode.wrappedValue.dismiss()
                    }
            } else if viewModel.isLoading {
                Loader()
            } else {
                ScrollView {
                    VStack(spacing: 20) {

                        Text("MsgTitlePetRegister")
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
                                Text(petTypeSelected.isEmpty || petChanged ? String(localized: "MsgSelectTypePet") : petTypeSelected)
                                Spacer()
                                Image(systemName: "arrowtriangle.down.fill")
                            }
                        })
                        .foregroundColor(.black)
                        .onAppear {
                            petChanged = false
                        }

                        Divider()
                        DatePicker("MsgDateBirthDay", selection: $selectedDate, displayedComponents: .date)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 1)
                            )

                        TextField("MsgName", text: $name)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 1)
                            )

                        if !image.isEqual(UIImage()) {
                            Image(uiImage: self.image)
                                .resizable()
                                .cornerRadius(50)
                                .padding(.all, 4)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                        }

                        Button(action: {
                            showUploadPhoto = true
                        }, label: {
                            Text("MsgUploadProfilePhoto")
                                .fontWeight(.bold)
                                .foregroundColor(Color.bluePrincipal)
                        })


                        Button(action: {
                            viewModel.petRegister(PetRegister(birthDate: selectedDate,
                                                              pet: selectedAnimal.rawValue,
                                                              name: name,
                                                              petType: petTypeSelected), self.image)
                        }, label: {
                            Text("MsgAdd")
                                .modifier(GenTextStylePrincipal())
                        })
                        .modifier(GenButtonPrincipal())
                    }
                    .padding(.horizontal, 60)
                    .padding([.top, .bottom], 20)
                    .background(Color.backgroundPrincipal)
                }
            }
        }
        .modifier(GenNavigationBar())
        .background(Color.backgroundPrincipal)
        .foregroundColor(.black)
        .task {
            showPetRegisterView = true
            viewModel.getPetsType()
        }
        .sheet(isPresented: $showUploadPhoto) {
            ImagePicker(selectedImage: self.$image, sourceType: .photoLibrary)
        }
    }
}

struct AnimalIconView: View {
    @Binding var selectedAnimal: PetType
    @Binding var petChanged: Bool
    var pet: PetType

    var body: some View {
        VStack {
            
            if let imageAnimal = ImageAnimals(rawValue: pet.rawValue)?.getImage() {
                
                imageAnimal
                    .font(.system(size: 100))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.bluePrincipal, lineWidth: isSelected(for: pet) ? 4 : .zero)
                    )
                    .onTapGesture {
                        if pet != selectedAnimal {
                            petChanged = true
                        }
                        selectedAnimal = pet
                    }
            }
                

            Text("MsgSelected")
                .font(.headline)
                .foregroundColor(isSelected(for: pet) ? Color.bluePrincipal : .clear)
        }
    }

    func isSelected(for animal: PetType) -> Bool {
        return selectedAnimal == animal
    }
}

#Preview {
    PetRegisterView(showPetRegisterView: .constant(true))
}
