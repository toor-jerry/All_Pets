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

struct LoginView: View {

    @EnvironmentObject var viewModel: AuthLoginViewModel

    @State var userName: String = ""
    @State var password: String = ""

    var body: some View {
        VStack {
            Image(Constants.logo)
                .resizable()
                .scaledToFit()
                .frame(height: 300)

            
            TextField(String.MsgEmailLogin, text: $userName)
                .modifier(inputStylePrincipal())
                .keyboardType(.emailAddress)
                .onChange(of: userName, perform: { text in
                    print(text)
                })

            SecureField(String.MsgPasswordLogin, text: $password)
                .modifier(inputStylePrincipal())
                .padding(.top, 15)
                .keyboardType(.emailAddress)
                .onChange(of: password, perform: { text in
                    print(text)
                })

            Button(action: {

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

        }
    }
}
