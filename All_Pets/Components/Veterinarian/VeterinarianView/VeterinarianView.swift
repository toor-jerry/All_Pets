//  VeterinarianView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 31/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct VeterinarianView: View {

    @StateObject var viewModel = VeterinarianViewModel(useCase: VeterianUseCaseUseCase())
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                Loader()
            } else {
                if viewModel.userHasLocation {
                    List {
                        ForEach(viewModel.offices, id: \.idOffice) { office in
                            VeterianCardCell(office: office)
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .modifier(shadowStyle1())
                                .padding(.bottom, 18)
                                .padding(.horizontal, 8)
                        )
                        .listRowSeparator(.hidden)
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    UserHasLocationView()
                }
            }
        }
        .modifier(NavigationBarModifier())
        .background(Color.background)
        .task {
            viewModel.getOffices()
        }
    }
}

struct VeterinarianViewPreviews: PreviewProvider {
    static var previews: some View {
        VeterinarianView()
    }
}

struct VeterianCardCell: View {

    var office: OfficeModel
    private let sizeImage: CGFloat = 50.0
    private var pets: String = ""

    init(office: OfficeModel) {
        self.office = office
        self.pets = office.specializedSector?.formatArrayToString() ?? ""
    }

    var body: some View {
        HStack {

            Image("LogoVeterian")
                .resizable()
                .frame(width: sizeImage, height: sizeImage)
                .padding(5)
                .aspectRatio(contentMode: .fill)
                .padding(.bottom, 20)
                .padding(.trailing, 10)

            VStack(spacing: 5) {

                Text(office.name ?? "")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.51, green: 0.39, blue: 0.62))
                    .font(.title3)
                    .modifier(AligmentView(aligment: .leading))

                Text("\(String.WordPets): \(pets)")
                    .font(.callout)
                    .foregroundColor(.black)
                    .modifier(AligmentView(aligment: .leading))
            }
        }
        .padding(10)
    }
}
