//  Modifiers.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 10/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

// - textStylePrincipal

struct textStylePrincipal_example: View {

    var body: some View {
        VStack {
            Text("Example on text")
                .modifier(textStylePrincipal())
        }
        .background(.black)
    }
}

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


// -

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

// - buttonPrincipal

struct buttonPrincipal_example: View {

    var body: some View {
        Button("Example buttonPrincipal", action: {})
            .modifier(buttonPrincipal())
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

// - buttonSecundary

struct buttonSecundary_example: View {

    var body: some View {
//        Button("Example buttonPrincipal", action: {})
//            .modifier(buttonSecundary())
        Button(action: {}, label: {
            Text("buttonSecundary")
                .padding(.leading, 20)
            Spacer()
                Image(systemName: "rectangle.portrait.and.arrow.right")
        })
        .modifier(buttonSecundary())
    }
}

struct buttonSecundary: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.title3)
            .frame(height: 34)
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .background(.white)
            .foregroundColor(.black.opacity(0.5))
            .cornerRadius(8)
            .modifier(shadowStyle1())
    }
}

// - inputStylePrincipal

struct inputStylePrincipal_example: View {

    var body: some View {
        VStack {
            Text("Example on text")
                .modifier(inputStylePrincipal())
        }
        .background(.black)
    }
}

struct inputStylePrincipal: ViewModifier {

    func body(content: Content) -> some View {
        content
            .autocapitalization(.none)
            .font(.headline)
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(Color.principal, lineWidth: 4))
    }
}

// - shadowStyle1

struct shadowStyle1_example: View {

    var body: some View {
        Button("Example shadow", action: { })
            .modifier(shadowStyle1())
    }
}

struct shadowStyle1: ViewModifier {

    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
    }
}

struct modifiers_examplePreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            textStylePrincipal_example()
                .padding()
            inputStylePrincipal_example()
                .padding()
            shadowStyle1_example()
                .padding()
            buttonPrincipal_example()
                .padding()
            buttonSecundary_example()
                .padding()
        }
    }
}
