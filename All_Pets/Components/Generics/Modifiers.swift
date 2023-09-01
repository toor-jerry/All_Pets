//  Modifiers.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 10/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct AligmentView: ViewModifier {

    var aligment: TextAlignment

    func body(content: Content) -> some View {
        HStack {
            if aligment == .trailing {
                Spacer()
            }
            content
            if aligment == .leading {
                Spacer()
            }
        }
    }
}

struct imageSize: ViewModifier {

    var size: CGFloat
    var padding: CGFloat

    init(size: CGFloat = 40, padding: CGFloat = 4) {
        self.size = size
        self.padding = padding
    }

    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size)
            .aspectRatio(contentMode: .fill)
            .padding(.all, padding)
    }
}

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor? = UIColor(Color.background),
         titleColor: UIColor? = .black) {

        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

// - textProfileBackground

struct textProfileBackground_example: View {

    var body: some View {
        VStack {
            Text("Example on text")
                .modifier(textStylePrincipal())
        }
        .background(.black)
    }
}

struct textProfileBackground: ViewModifier {

    func body(content: Content) -> some View {
        content
            .cornerRadius(50)
            .padding(.all, 4)
            .frame(width: 40, height: 40)
            .background(Color.black.opacity(0.2))
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
    }
}

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

    private var color: Color = Color.principal
    init(_ color: Color = Color.principal) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .background(color)
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

    var color: Color

    init(_ color: Color = Color.principal) {
        self.color = color
    }

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(color, lineWidth: 4))
            .foregroundColor(.black)
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
