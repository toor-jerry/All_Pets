//  EmergencyView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 28/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import MapKit

struct EmergencyView: View {
    
    @StateObject var viewModel = EmergencyViewModel(useCase: EmergencyUseCase())

    var body: some View {
        VStack {
            if viewModel.isLoading {
                Loader()
            } else {

                if viewModel.userHasLocation {
                    Map(coordinateRegion: $viewModel.officeCoordinates, showsUserLocation: true, userTrackingMode: .constant(.none), annotationItems: viewModel.mapPins) { pin in

                        MapMarker(coordinate: pin.coordinate)
                    }

                    Button(action: {

                    }, label: {
                        Text(String.MsgSendAlert)
                            .modifier(textStylePrincipal())
                    })
                    .modifier(buttonPrincipal(.red))
                    .padding(.top, 20)
                    .padding(.bottom, 20)
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

struct EmergencyViewPreviews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
    }
}
