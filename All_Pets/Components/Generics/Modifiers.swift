//  Modifiers.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 10/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct textStylePrincipal: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.title3)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .frame(width: 150, height: 19, alignment: .top)
    }
}

struct textStyleSubtitle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.gray.opacity(0.8))
    }
}

struct textStyleTitle2: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.gray.opacity(0.8))
    }
}

struct buttonPrincipal: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .background(Color.principal)
            .cornerRadius(50)
            .modifier(shadowStyle1())
    }
}

struct inputStylePrincipal: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding(20)
            .font(.headline)
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.principal, lineWidth: 4))
            .padding(.horizontal, 40)
    }
}

struct shadowStyle1: ViewModifier {

    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
    }
}
