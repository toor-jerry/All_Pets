//  SignUpView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct SignUpView: View {

    @Binding var section: AuthSections
    @StateObject var viewModel = SignUpViewModelViewModel(useCase: SignUpUseCase())
    
    @State private var data: SignUpModel = SignUpModel()
    
    @State private var passwordTemp: String = ""
    @State private var formComplete: Bool = false
    
    var body: some View {
        if viewModel.isLoading {
            Loader()
        } else {
            VStack {
                VStack(spacing: 20) {
                    TextField(String.MsgName, text: $data.name)
                        .padding()
                        .modifier(inputStylePrincipal())
                        .keyboardType(.asciiCapable)
                        .foregroundColor(.black)
                    
                    TextField(String.MsgFirstLastName, text: $data.firstLastName)
                        .padding()
                        .modifier(inputStylePrincipal())
                        .keyboardType(.asciiCapable)
                    
                    TextField(String.MsgSecondLastName, text: $data.secondLastName)
                        .padding()
                        .modifier(inputStylePrincipal())
                        .keyboardType(.asciiCapable)
                    
                    TextField(String.MsgEmailLogin, text: $data.email)
                        .padding()
                        .modifier(inputStylePrincipal())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField(String.MsgPasswordLogin, text: $data.password)
                        .padding()
                        .modifier(inputStylePrincipal())
                        .autocapitalization(.none)
                    
                    SecureField(String.MsgRepeatLogin, text: $passwordTemp)
                        .padding()
                        .modifier(inputStylePrincipal())
                        .autocapitalization(.none)
                    
                    Button(action: {
                        validateForm()
                    }, label: {
                        Text(String.MsgButtonSignUp)
                            .modifier(textStylePrincipal())
                    })
                    .modifier(buttonPrincipal())
                }
                .disableAutocorrection(true)
                .padding(.horizontal, 60)
                .padding(.top, 20)
                Spacer()
            }
            .background(Color.background)
            .multilineTextAlignment(.center)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(String.MsgWarning),
                    message: Text(String.MsgFormIncomplete),
                    dismissButton: .default(Text(String.MsgAcept))
                )
            }.navigationTitle(String.MsgSignUpTitleHeader)
                .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func validateForm() {
        
        if validateData() {
            viewModel.signUp(data: data) { section in
                if let section = section {
                    self.section = section
                }
            }
        } else {
            viewModel.showAlert = true
        }
    }
    
    private func validateData() -> Bool {
        let passwordEquals: Bool = data.password.elementsEqual(passwordTemp) && !passwordTemp.isEmpty
        
        if passwordEquals {
            return true
        }
        
        return false
    }
}

struct SignUpViewPreviews: PreviewProvider {
    static var previews: some View {
        let section: AuthSections = .signUp
        SignUpView(section: .constant(section))
    }
}
