//  AuthLoginView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct AuthLoginView: View {
    
    @StateObject var viewModel = AuthLoginViewModel(useCase: PreAuthLoginUseCase())
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                Loader().task {
                    viewModel.auth()
                }
            } else {
                if viewModel.isLoggedIn {
                    Text("Logueado")
                } else {
                    LoginView()
                }
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
