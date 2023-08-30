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
                Map(coordinateRegion: $viewModel.officeCoordinates, showsUserLocation: true, userTrackingMode: .constant(.follow))
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
