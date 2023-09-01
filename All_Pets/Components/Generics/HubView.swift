//  HubView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 10/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct HubView: View {
    
    @Binding var section: AuthSections
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {

            HomeView()
                .modifier(tabItemStyle())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Inicio")
                }
                .tag(0)
            
            VeterinarianView()
            .modifier(tabItemStyle())
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Veterinario")
            }
            .tag(1)

            EmergencyView()
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
                ProfileView(section: $section)
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
        let section: AuthSections = .signUp
        HubView(section: .constant(section))
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
