//  ProfileView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ProfileView: View {

    @Binding var section: AuthSections
    @EnvironmentObject var sessionInfo: SessionInfo

    @StateObject var viewModel = ProfileViewModel(useCase: SignOutUseCase())

    var body: some View {

        if viewModel.isLoading {
            Loader()
        } else {
            VStack {

                Image(.allPets)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)

                Text("\(String(localized: "MsgHello")) \(sessionInfo.user.name)!")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .foregroundColor(.black)


                Text("WordsNewFunctionalities")
                    .font(.title3)
                    .padding(.top, 20)
                    .foregroundColor(Color(.purpleSecundary))

                Spacer()

                Button(action: {
                    viewModel.signOut() { section in
                        if section == .login {
                            self.section = .login
                        }
                    }
                }, label: {
                    Text("MsgSignOut")
                    Spacer()
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                })
                .modifier(buttonSecundary())
                .padding(.bottom, 80)
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
