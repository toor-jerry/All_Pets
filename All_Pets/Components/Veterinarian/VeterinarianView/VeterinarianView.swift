//  VeterinarianView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 31/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import AllPetsCommons

struct VeterinarianView: View {
    
    @StateObject var viewModel = VeterinarianViewModel(useCase: VeterianUseCase())

    var body: some View {
        
        NavigationStack {
            
            if viewModel.isLoading {
                Loader()
            } else {
                VStack {
                    if viewModel.userHasLocation {
                        
                        Text("MsgTitleVeterin")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.title2)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                        
                        FilterView(showButtonFilter: true, listSector: $viewModel.filterSector, buttonFilterSelected: $viewModel.showFilterBottomSheet, filterSelected: $viewModel.filterChipsSelected, filterSectorSelected: $viewModel.filterSectorSelected)
                        
                        List {
                            ForEach(viewModel.offices, id: \.idOffice) { office in
                                VeterianCardCell(office: office)
                                    .onTapGesture {
                                        viewModel.goToDetail(of: office)
                                    }
                            }
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.white)
                                    .modifier(GenShadowStyle())
                                    .padding(.bottom, 18)
                                    .padding(.horizontal, 8)
                            )
                            .listRowSeparator(.hidden)
                        }
                        .scrollContentBackground(.hidden)
                    } else {
                        UserHasLocationView()
                    }
                }.modifier(GenNavigationBar())
                    .background(Color.backgroundPrincipal)
                    .navigationDestination(isPresented: $viewModel.showDetail, destination: {
                        if let office = viewModel.officeSelected {
                            VeterinarianDetailView(office: office, mapData: MapData(userHasLocation: viewModel.userHasLocation, userTrackingMode: viewModel.userTrackingMode, pointCoordinates: viewModel.officeCoordinates, distanceToUserLocation: viewModel.officeSelected?.distanceToUserLocation, titleLocation: viewModel.officeSelected?.name), mapPins: viewModel.mapPins)
                        }
                    })
            }
        }
        .sheet(isPresented: $viewModel.showFilterBottomSheet) {
            VeterianFilterChipsView(viewModel: viewModel)
        }
        .task {
            viewModel.getOffices()
        }
    }
}


#Preview {
    VeterinarianView()
}
