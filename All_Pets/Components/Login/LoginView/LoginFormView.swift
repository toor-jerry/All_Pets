//  LoginFormView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 10/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import AllPetsCommons

struct LoginFormView: View {
    
    @EnvironmentObject var viewModel: AuthLoginViewModel
    
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var showPassword = false
    @State private var userNameValidate: Bool = true
    @State private var passwordValidate: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(.allPets)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                
                TextField("MsgEmailLogin", text: $userName)
                    .padding()
                    .modifier(GenInputStylePrincipal(userNameValidate ? .bluePrincipal : .redPrincipal))
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal, 40)
                
                VStack {
                    VStack {
                        if showPassword {
                            TextField("MsgPasswordLogin", text: $password)
                                .disableAutocorrection(true)
                                .textContentType(.password)
                                .keyboardType(.asciiCapable)
                        } else {
                            SecureField("MsgPasswordLogin", text: $password)
                        }
                    }
                    .autocapitalization(.none)
                    .padding()
                    .padding(.trailing, 50)
                    .modifier(GenInputStylePrincipal(passwordValidate ? .bluePrincipal : .redPrincipal))
                }
                .overlay(alignment: .trailing, content: {
                    ShorOrHideButton(showPassword: $showPassword)
                        .padding(.trailing, 20)
                })
                .padding(.top, 15)
                .padding(.horizontal, 40)
                
                if viewModel.showAlert || !viewModel.msgAler.isEmpty {
                    Text(viewModel.msgAler)
                        .fontWeight(.bold)
                        .foregroundColor(Color.redPrincipal)
                }
                
                Button(action: {
                    login()
                }, label: {
                    Text("MsgButtonLogin")
                        .modifier(GenTextStylePrincipal())
                })
                .modifier(GenButtonPrincipal())
                .padding(.top, 20)
                
                NavigationLink {
                    ForgotPasswordView()
                } label: {
                    Text("MsgForgotPassword")
                        .modifier(GenTextStyleSubtitle())
                }.padding(.top, 15)
                
                NavigationLink(destination: SignUpView(section: $viewModel.section),
                               label: {
                    HStack {
                        Text("MsgSignUpTitle")
                            .modifier(GenTextStyleSubtitle())
                        
                        Text("MsgSignUp")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.gray.opacity(0.8))
                    }
                })
                Spacer()
            }
            .background(Color.backgroundPrincipal)
        }
    }
    
    private func login() {
        viewModel.login(info: AuthLoginInfo(password: password, user: userName))
        userNameValidate = viewModel.isValidEmail(userName)
        passwordValidate = !password.isEmpty
    }
}

#Preview {
    LoginFormView().environmentObject(AuthLoginViewModel(useCase: PreAuthLoginUseCase()))
}
