//  EmergencyView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 28/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct EmergencyView: View {
    
    @StateObject var viewModel = EmergencyViewModel(useCase: EmergencyUseCase())
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                Loader()
            } else {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
