//  SignUpView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct SignUpView: View {

    @StateObject var viewModel = SignUpViewModelViewModel(useCase: SignUpUseCase())

    @State private var data: SignUpModel = SignUpModel()

    @State private var passwordTemp: String = ""
    @State private var formComplete: Bool = false

    var body: some View {
        VStack {
            Text(String.MsgSignUpTitleHeader)
                .font(.title)
                .fontWeight(.bold)

            VStack(spacing: 20) {
                TextField(String.MsgName, text: $data.name)
                    .padding()
                    .modifier(inputStylePrincipal())
                    .keyboardType(.asciiCapable)
                    .autocapitalization(.words)

                TextField(String.MsgFirstLastName, text: $data.firstLastName)
                    .padding()
                    .modifier(inputStylePrincipal())
                    .keyboardType(.asciiCapable)
                    .autocapitalization(.words)

                TextField(String.MsgSecondLastName, text: $data.secondLastName)
                    .padding()
                    .modifier(inputStylePrincipal())
                    .keyboardType(.asciiCapable)
                    .autocapitalization(.words)

                TextField(String.MsgEmailLogin, text: $data.email)
                    .padding()
                    .modifier(inputStylePrincipal())
                    .keyboardType(.emailAddress)

                SecureField(String.MsgPasswordLogin, text: $data.password)
                    .padding()
                    .modifier(inputStylePrincipal())

                SecureField(String.MsgRepeatLogin, text: $passwordTemp)
                    .padding()
                    .modifier(inputStylePrincipal())

                Button(action: {
                    validateForm()
                }, label: {
                    Text(String.MsgButtonSignUp)
                        .modifier(textStylePrincipal())
                })
                .modifier(buttonPrincipal(formComplete ? .principal : .gray.opacity(0.5)))
            }
            .disableAutocorrection(true)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 60)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(String.MsgWarning),
                message: Text(String.MsgFormIncomplete),
                dismissButton: .default(Text(String.MsgAcept))
            )
        }
    }

    private func validateForm() {

        if validateData() {
            viewModel.signUp(data: data)
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
        SignUpView()
    }
}
