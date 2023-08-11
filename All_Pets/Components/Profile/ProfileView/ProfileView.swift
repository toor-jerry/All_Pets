//  ProfileView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ProfileView: View {

    @StateObject var viewModel = ProfileViewModel(useCase: SignUpUseCase())
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ProfileViewPreviews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

