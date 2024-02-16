//  ForgotPasswordView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/02/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @StateObject var viewModel = ForgotPasswordViewModel(useCase: ForgotPasswordUseCase())
    @State private var email: String = ""
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                Loader()
            } else {
                VStack {
                    Text("WordsExploreTitle")
                        .font(.title3)
                    
                        .modifier(AligmentView(aligment: .leading))
                    
                    TextField("WordsSelectTheReason", text: $email)
                        .padding()
                        .modifier(inputStylePrincipal(.gray.opacity(0.4), 2))
                        .keyboardType(.asciiCapable)
                        .foregroundColor(.black)
                    
                    Button(action: {
                        viewModel.forgotPassword(email: email)
                    }, label: {
                        Text("WordsToAskForADate")
                            .modifier(textStylePrincipal())
                    })
                    .modifier(buttonPrincipal(Color(.limeGreen)))
                    
                    if viewModel.isError {
                        Text("zas sfsdfs sdfsf sdfsdf sdfsdf dsfsdf sdfsdf sdfsdf sfsdf")
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
        .background(Color(.backgroundPrincipal))
    }
}

#Preview {
    ForgotPasswordView()
}
