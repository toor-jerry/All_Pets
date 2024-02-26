//  ForgotPasswordView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/02/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import AllPetsColors

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
                        .modifier(AligmentView(aligment: .leading))
                    
                    TextField("", text: $email)
                        .padding()
                        .modifier(inputStylePrincipal(.gray.opacity(0.4), 2))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .foregroundColor(.black)
                    
                    Button(action: {
                        viewModel.forgotPassword(email: email)
                    }, label: {
                        Text("MsgRecoverPassword")
                            .modifier(textStylePrincipal(setWidth: false))
                    })
                    .modifier(buttonPrincipal(.limeGreen, 20))
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
