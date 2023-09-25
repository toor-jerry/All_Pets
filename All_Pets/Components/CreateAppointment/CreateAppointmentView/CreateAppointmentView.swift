//  CreateAppointmentView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 22/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct CreateAppointmentView: View {

    //    @StateObject var viewModel = CreateAppointmentViewViewModel(useCase: CreateAppointmentViewUseCase())
    @EnvironmentObject var sessionInfo: SessionInfo

    var body: some View {
        VStack {
            Text(String(describing: sessionInfo.petSelected))
        }
        .background(Color.background)
        .foregroundColor(.black)
    }
}

#Preview {
    CreateAppointmentView()
}
