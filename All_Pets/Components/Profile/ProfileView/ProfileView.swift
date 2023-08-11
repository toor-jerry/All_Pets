//  ProfileView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ProfileView: View {

    @StateObject var viewModel = ProfileViewModel(useCase: SignOutUseCase())
    
    var body: some View {
        VStack {

            Circle()
                .frame(height: 200)
                .foregroundColor(Color.principal)

            Spacer()
            
            Button(action: {
                viewModel.signOut()
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

struct ProfileViewPreviews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

