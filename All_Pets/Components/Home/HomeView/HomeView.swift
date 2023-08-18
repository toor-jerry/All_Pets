//  HomeView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 17/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct HomeView: View {

    //    @StateObject var viewModel = HomeViewViewModel(useCase: HomeViewUseCase())
    
    @State private var isModalPresented = false

    var body: some View {
        Button("Present Modal") {
            isModalPresented.toggle()
        }
        .sheet(isPresented: $isModalPresented) {
            ModalView()
        }
    }
}

struct ModalView: View {
    var body: some View {
        VStack {
            Text("This is a modal view")
                .font(.title)
                .padding()
            Button("Button 1") {
                // Acción del botón 1
            }
            .padding()
            Button("Button 2") {
                // Acción del botón 2
            }
            .padding()

            // Agregar un Spacer para que el contenido se expanda
            Spacer()
        }
    }
}

struct HomeViewPreviews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

