//  VeterianFilterChipsView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 06/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct VeterianFilterChipsView: View {
    
    @StateObject var viewModel: VeterinarianViewModel
    @State var heightFirstContainerChips: CGFloat = .zero
    @State var heightSecondContainerChips: CGFloat = .zero
    
    var body: some View {
        VStack {
            ScrollView {
                Text(String.WordSpecialities)
                    .fontWeight(.bold)
                    .font(.body)
                    .modifier(AligmentView(aligment: .leading))
                    .padding(.leading, 10)
                    .padding(.top, 20)
                
                ChipContainerView(chipArray: $viewModel.chipsSpecialities, updateHeigh: { height in
                    if self.heightFirstContainerChips != height && height > self.heightFirstContainerChips {
                        self.heightFirstContainerChips = height
                    }
                }).frame(height: heightFirstContainerChips)
                
                Text(String.WordsSpecificInquiries)
                    .fontWeight(.bold)
                    .font(.body)
                    .modifier(AligmentView(aligment: .leading))
                    .padding(.leading, 10)
                ChipContainerView(chipArray: $viewModel.chipsSector, updateHeigh: { height in
                    if Int(self.heightSecondContainerChips) != Int(height) && Int(height) > Int(self.heightSecondContainerChips) {
                        self.heightSecondContainerChips = height
                    }
                }).frame(height: heightSecondContainerChips)
            }
            .foregroundColor(.black)
            
            Button(action: {
                viewModel.filterByChips()
            }, label: {
                Text(String.WordApply)
                    .modifier(textStylePrincipal())
            })
            .modifier(buttonPrincipal(.limeGreen))
            
        }
        .presentationDetents([.large])
        .padding(.top, 40)
        .padding(20)
        .background(Color.background)
    }
}

struct VeterianFilterChipsViewPreviews: PreviewProvider {
    static var previews: some View {
        @StateObject var viewModel = VeterinarianViewModel(useCase: VeterianUseCaseUseCase())

        VeterianFilterChipsView(viewModel: viewModel)
            .task {
            viewModel.chipsSpecialities = [ChipModel(titleKey: "Test1"), ChipModel(titleKey: "Word 2")]
        }
    }
}
