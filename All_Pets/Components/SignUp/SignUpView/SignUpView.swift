//  SignUpView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import AllPetsCommons

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
                    TextField("MsgName", text: $data.name)
                        .padding()
                        .modifier(GenInputStylePrincipal())
                        .keyboardType(.asciiCapable)
                        .foregroundColor(.black)
                    
                    TextField("MsgFirstLastName", text: $data.firstLastName)
                        .padding()
                        .modifier(GenInputStylePrincipal())
                        .keyboardType(.asciiCapable)
                    
                    TextField("MsgSecondLastName", text: $data.secondLastName)
                        .padding()
                        .modifier(GenInputStylePrincipal())
                        .keyboardType(.asciiCapable)
                    
                    TextField("MsgEmailLogin", text: $data.email)
                        .padding()
                        .modifier(GenInputStylePrincipal())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("MsgPasswordLogin", text: $data.password)
                        .padding()
                        .modifier(GenInputStylePrincipal())
                        .autocapitalization(.none)
                    
                    SecureField("MsgRepeatLogin", text: $passwordTemp)
                        .padding()
                        .modifier(GenInputStylePrincipal())
                        .autocapitalization(.none)
                    
                    Button(action: {
                        validateForm()
                    }, label: {
                        Text("MsgButtonSignUp")
                            .modifier(GenTextStylePrincipal())
                    })
                    .modifier(GenButtonPrincipal())
                }
                .disableAutocorrection(true)
                .padding(.horizontal, 60)
                .padding(.top, 20)
                Spacer()
            }
            .modifier(GenNavigationBar())
            .background(Color.backgroundPrincipal)
            .multilineTextAlignment(.center)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("MsgWarning"),
                    message: Text("MsgFormIncomplete"),
                    dismissButton: .default(Text("MsgAcept"))
                )
            }.navigationTitle("MsgSignUpTitleHeader")
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

#Preview {
    VStack {
        let section: AuthSections = .signUp
        SignUpView(section: .constant(section))
    }
}
