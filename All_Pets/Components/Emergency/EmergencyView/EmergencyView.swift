//  EmergencyView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 28/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import MapKit

struct MapViewPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let subtitle: String
}

struct EmergencyView: View {
    
    @StateObject var viewModel = EmergencyViewModel(useCase: EmergencyUseCase())

    var body: some View {
        VStack {
            if viewModel.isLoading {
                Loader()
            } else {
                if !viewModel.mapPins.isEmpty {
                    Map(coordinateRegion: $viewModel.officeCoordinates, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: viewModel.mapPins) { pin in

                        MapMarker(coordinate: pin.coordinate)
                    }

                    Button(action: {

                    }, label: {
                        Text(String.MsgButtonLogin)
                            .modifier(textStylePrincipal())
                    })
                    .modifier(buttonPrincipal(.red))
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                }

                if viewModel.userHasLocation {
                    Text("Localización Aceptada ✅")
                        .bold()
                        .padding(.top, 12)
                    Link("Pulsa para cambiar la autorización de Localización", destination: URL(string: UIApplication.openSettingsURLString)!)
                        .padding(32)
                } else {
                    Text("Localización NO Aceptada ❌")
                        .bold()
                        .padding(.top, 12)
                    Link("Pulsa para aceptar la autorización de Localización", destination: URL(string: UIApplication.openSettingsURLString)!)
                        .padding(32)
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
