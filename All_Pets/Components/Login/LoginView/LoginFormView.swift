//  LoginFormView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 10/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct LoginFormView: View {

    @StateObject var viewModel: LoginViewModel

    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var showPassword = false

    var body: some View {
        VStack {
            Image(Constants.logo)
                .resizable()
                .scaledToFit()
                .frame(height: 300)

            TextField(String.MsgEmailLogin, text: $userName)
                .padding()
                .modifier(inputStylePrincipal())
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .padding(.horizontal, 40)

            VStack {
                VStack {
                    if showPassword {
                        TextField(String.MsgPasswordLogin, text: $password)
                            .disableAutocorrection(true)
                            .textContentType(.password)
                            .keyboardType(.asciiCapable)
                    } else {
                        SecureField(String.MsgPasswordLogin, text: $password)
                    }
                }
                .padding()
                .padding(.trailing, 50)
                .modifier(inputStylePrincipal())
            }
            .overlay(alignment: .trailing, content: {
                ShorOrHideButton(showPassword: $showPassword)
                    .padding(.trailing, 20)
            })
            .padding(.top, 15)
            .padding(.horizontal, 40)

            Button(action: {
                viewModel.login(info: AuthLoginInfo(password: password, user: userName))
            }, label: {
                Text(String.MsgButtonLogin)
                    .modifier(textStylePrincipal())
            })
            .modifier(buttonPrincipal())
            .padding(.top, 20)

            Button(action: {

            }, label: {
                Text(String.MsgForgotPassword)
                    .modifier(textStyleSubtitle())

            })
            .padding(.top, 15)

            Button(action: {
                
            }, label: {
                Text(String.MsgSignUpTitle)
                    .modifier(textStyleSubtitle())

                Text(String.MsgSignUp)
                    .modifier(textStyleTitle2())

            })
            .padding(.top, 60)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(String.MsgWarning),
                    message: Text(String.MsgPasswordOrUserInvalid),
                    dismissButton: .default(Text(String.MsgAcept))
                )
            }
        }
    }
}

struct LoginFormViewPreviews: PreviewProvider {
    static var previews: some View {
        LoginFormView(viewModel: LoginViewModel(useCase: AuthLoginUseCase()))
    }
}
