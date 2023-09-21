//  ShorOrHideButton.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 11/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ShorOrHideButton: View {
    
    @Binding var showPassword: Bool

    var body: some View {
        Button(action: {
            showPassword.toggle()
        }) {
            Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                .font(.system(size: 24))
        }
        .foregroundColor(.gray)
    }
}

#Preview {
    ShorOrHideButton(showPassword: .constant(false))
}
