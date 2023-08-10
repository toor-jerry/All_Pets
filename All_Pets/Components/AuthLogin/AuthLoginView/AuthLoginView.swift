//  AuthLoginView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct AuthLoginView: View {
    @StateObject var viewModel = AuthLoginViewModel(useCase: AuthLoginUseCase())
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Cargando..")
                    .scaleEffect(2)
                    .task {
                        viewModel.auth()
                    }
            } else {
                Text("")
            }
        }
        .environmentObject(viewModel)
    }
}

struct AuthLoginViewPreviews: PreviewProvider {
    static var previews: some View {
        AuthLoginView()
    }
}
