//  VeterinarianView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 31/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct VeterinarianView: View {

    @StateObject var viewModel = VeterinarianViewModel(useCase: VeterianUseCaseUseCase())
    @State var filterSelected: Int = .zero
    @State var buttonFilterSelected: Bool = false
    
    var body: some View {
        
        NavigationStack {

            if viewModel.isLoading {
                Loader()
            } else {
                VStack {
                    if viewModel.userHasLocation {

                        Text(String.MsgTitleVeterin)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.title2)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)

                        FilterView(listSector: viewModel.filterSector, showButtonFilter: true, sectorSelected: $filterSelected, buttonFilterSelected: $buttonFilterSelected)

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
                }.modifier(NavigationBarModifier())
                    .background(Color.background)
            }
        }
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
