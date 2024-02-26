//  EmergencyView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 28/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import MapKit
import AllPetsCommons

struct EmergencyView: View {

    @StateObject var viewModel = EmergencyViewModel(useCase: EmergencyUseCase())

    var body: some View {
        VStack {
            if viewModel.isLoading {
                Loader()
            } else {

                if viewModel.userHasLocation {
                    ZStack {
                        Map(coordinateRegion: $viewModel.officeCoordinates, showsUserLocation: true, userTrackingMode: .constant(viewModel.userTrackingMode), annotationItems: viewModel.mapPins) { pin in

                            MapMarker(coordinate: pin.coordinate)
                        }

                        VStack {
                            MapLocationIconsView(userTrackingMode: viewModel.userTrackingMode, distanceToUserLocation: viewModel.office?.distanceToUserLocation, titleLocation: viewModel.office?.name, mapLocationIconsPadding: .large)

                            Spacer()

                            Button(action: {

                            }, label: {
                                Text("MsgSendAlert")
                                    .modifier(GenTextStylePrincipal())
                            })
                            .modifier(GenButtonPrincipal(color: .red))
                            .padding(.bottom, 100)
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                } else {
                    UserHasLocationView()
                }
            }
        }
        .task {
            viewModel.getOffices()
        }
    }
}

#Preview {
    EmergencyView()
}
