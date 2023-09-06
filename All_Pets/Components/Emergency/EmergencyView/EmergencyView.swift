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
                    ZStack {
                        Map(coordinateRegion: $viewModel.officeCoordinates, showsUserLocation: true, userTrackingMode: .constant(viewModel.userTrackingMode), annotationItems: viewModel.mapPins) { pin in

                            MapMarker(coordinate: pin.coordinate)
                        }

                        VStack {
                            Spacer()
                            Button(action: {
                                viewModel.userTrackingMode = viewModel.userTrackingMode == .follow ? .none : .follow
                            }, label: {
                                Image(systemName: viewModel.userTrackingMode == .follow ? "location.fill" : "location")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                    .padding(20)
                            })
                            .modifier(AligmentView(aligment: .trailing))
                        }
                    }
                    .edgesIgnoringSafeArea(.all)

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
