//  ForgotPasswordView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/02/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import AllPetsCommons

struct ForgotPasswordView: View {
    
    @StateObject var viewModel = ForgotPasswordViewModel(useCase: ForgotPasswordUseCase())
    @State private var email: String = ""
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                Loader()
            } else {
                VStack {
                    Text("MsgEnterYourEmail")
                        .font(.title3)
                        .modifier(GenAligmentView(aligment: .leading))
                    
                    TextField("", text: $email)
                        .padding()
                        .modifier(GenInputStylePrincipal(.gray.opacity(0.4), 2))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .foregroundColor(.black)
                    
                    Button(action: {
                        viewModel.forgotPassword(email: email)
                    }, label: {
                        Text("MsgRecoverPassword")
                            .modifier(GenTextStylePrincipal(setWidth: false))
                    })
                    .modifier(GenButtonPrincipal(padding: 20, color: .limeGreen))
                    .padding(.top, 15)
                    
                    if viewModel.isSuccess {
                        Text("MsgErrorForgotEmail")
                            .font(.title3)
                            .foregroundStyle(.gray)
                            .padding(.top, 20)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                }
                .padding(30)
            }
        }
        .background(Color.backgroundPrincipal)
    }
}

#Preview {
    ForgotPasswordView()
}
