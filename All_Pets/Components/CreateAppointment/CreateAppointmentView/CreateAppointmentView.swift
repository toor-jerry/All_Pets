//  CreateAppointmentView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 22/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct CreateAppointmentView: View {

    //    @StateObject var viewModel = CreateAppointmentViewViewModel(useCase: CreateAppointmentViewUseCase())
    @Binding var pets: [Pet]
    @Binding var petSelected: Pet?

    var body: some View {
        VStack {
            Text(String(describing: petSelected))
        }
        .background(Color.background)
        .foregroundColor(.black)
    }
}

#Preview {
    CreateAppointmentView(pets: .constant([]), petSelected: .constant(nil))
}
