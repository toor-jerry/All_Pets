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

                        FilterView(showButtonFilter: true, listSector: $viewModel.filterSector, buttonFilterSelected: $viewModel.showFilterBottomSheet)

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
        .sheet(isPresented: $viewModel.showFilterBottomSheet) {
            // TODO: add view for filter
            ChipContainerView(chipArray: $viewModel.chipsSector)
                .presentationDetents([.medium, .large])
                .background(Color.background)
                .foregroundColor(.black)
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
