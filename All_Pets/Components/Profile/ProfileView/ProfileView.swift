//  ProfileView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ProfileView: View {

    @Binding var section: AuthSections
    
    @StateObject var viewModel = ProfileViewModel(useCase: SignOutUseCase())
    
    var body: some View {
        
        if viewModel.isLoading {
            Loader()
        } else {
            VStack {

                Circle()
                    .frame(height: 200)
                    .foregroundColor(Color.principal)
//                Image(uiImage: self.image)
//                        .resizable()
//                        .cornerRadius(50)
//                        .padding(.all, 4)
//                        .frame(width: 100, height: 100)
//                        .background(Color.black.opacity(0.2))
//                        .aspectRatio(contentMode: .fill)
//                        .clipShape(Circle())
//                        .padding(8)

                Spacer()

                Button(action: {
                    viewModel.signOut() { section in
                        if section == .login {
                            self.section = .login
                        }
                    }
                }, label: {
                    Text(String.MsgSignOut)
                    Spacer()
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                })
                .modifier(buttonSecundary())
            }
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    VStack {
        let section: AuthSections = .signUp
        ProfileView(section: .constant(section))
    }
}
