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
            switch viewModel.section {
            case .verifySessionStarted:
                Loader()
                    .task {
                        viewModel.auth()
                    }
            case .loader:
                Loader()
            case .hub:
                HubView()
            case .login:
                LoginFormView()
            case .signUp:
                SignUpView()
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
