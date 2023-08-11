//  HubView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 10/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct HubView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            ScrollView {
                LoginFormView(viewModel: LoginViewModel(useCase: AuthLoginUseCase()))
            }
            .modifier(tabItemStyle())
            .tabItem {
                Image(systemName: "house.fill")
                Text("Inicio")
            }
            .tag(0)
            
            ScrollView {
                Text("Contenido de la pestaña 2")
            }
            .modifier(tabItemStyle())
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Veterinario")
            }
            .tag(1)
            
            ScrollView {
                Text("Contenido de la pestaña 3")
            }
            .modifier(tabItemStyle())
            .tabItem {
                Image(systemName: "exclamationmark.triangle.fill")
                Text("Emergencia")
            }
            .tag(2)
            
            ScrollView {
                Text("Contenido de la pestaña 3")
            }
            .modifier(tabItemStyle())
            .tabItem {
                Image(systemName: "safari")
                Text("Explora")
            }
            .tag(3)
            
            ScrollView {
                Text("Contenido de la pestaña 3")
            }
            .modifier(tabItemStyle())
            .tabItem {
                Image(systemName: "person.fill")
                Text("Perfil")
            }
            .tag(4)
        }
        .accentColor(Color.principal)
    }
}

struct HubView_Previews: PreviewProvider {
    static var previews: some View {
        HubView()
    }
}

struct tabItemStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(Color.background)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground( .white, for: .tabBar)
    }
}
