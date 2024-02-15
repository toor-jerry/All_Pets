//  ExploreView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/10/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

enum ExploreSections: String {
    case food
    case desserts
    case accesories
}

extension ExploreSections {
    func getTitle() -> String {
        switch self {
        case .food:
            return String(localized: "WordsFoodExplore")
        case .desserts:
            return String(localized: "WordsDessertsExplore")
        case .accesories:
            return String(localized: "WordsAccesoriesExplore")
        }
    }
}

struct ExploreView: View {

    @StateObject var viewModel = ExploreViewModel(useCase: ExploreUseCase())
    @State var showListExplore = false
    @State var exploreSection: ExploreSections?

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
                .background(Color.background)
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


    struct CardView: View {

        @State var exploreSection: ExploreSections
        private let heightImage: CGFloat = 80

        var body: some View {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: .infinity, height: heightImage)
                    .background(
                        Image(exploreSection.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .opacity(0.5)
                    )
                    .cornerRadius(20)
                    .modifier(shadowStyle1())
                HStack {
                    Text(exploreSection.getTitle())
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ExploreView()
}
