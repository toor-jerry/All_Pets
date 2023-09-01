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
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .background(Color.background)
    }
}

struct VeterinarianViewPreviews: PreviewProvider {
    static var previews: some View {
        VeterinarianView()
    }
}
