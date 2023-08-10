//  LoginView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 10/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct LoginView: View {

    @StateObject var viewModel = LoginViewModel(useCase: AuthLoginUseCase())

    @State private var userName: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {

            if viewModel.isLoading {
                Loader()
            } else if !viewModel.isLoggedIn {
                LoginFormView(viewModel: viewModel)
            } else {
                Text("Logeado")
            }
        }
    }
}

struct LoginViewPreviews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
