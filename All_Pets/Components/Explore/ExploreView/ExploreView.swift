//  ExploreView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/10/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import AllPetsCommons

struct ExploreView: View {

    @StateObject var viewModel = ExploreViewModel(useCase: ExploreUseCase())
    @State var showListExplore = false

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                Loader()
            } else {
                ScrollView {
                    Text("WordsExploreTitle")
                        .font(.title)
                        .foregroundColor(.black.opacity(0.5))
                        .fontWeight(.bold)
                        .padding(.top, 30)

                    VStack(spacing: 25) {
                        CardView(exploreSection: .desserts)
                            .onTapGesture {
                                exploreSection = .desserts
                                showListExplore.toggle()
                            }
                        CardView(exploreSection: .food)
                            .onTapGesture {
                                exploreSection = .food
                                showListExplore.toggle()
                            }
                        CardView(exploreSection: .accesories)
                            .onTapGesture {
                                exploreSection = .accesories
                                showListExplore.toggle()
                            }
                    }
                    .padding(.horizontal, 20)

                    Spacer()
                }
                .background(Color.backgroundPrincipal)
            }
        }
        .sheet(isPresented: $showListExplore) {
            // add section list
            //            VeterianFilterChipsView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.getBusiness()
        }
    }
}

#Preview {
    ExploreView()
}
