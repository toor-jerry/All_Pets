//  VeterinarianDetailView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 06/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct VeterinarianDetailView: View {
    
    let office: OfficeModel
    @State var heightFirstContainerChips: CGFloat = .zero
    
    @StateObject var viewModel = VeterinarianDetailViewModel()
    @State var iPhoneCounter: Float = .zero
    @State var isEditing: Bool = false
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VeterianImageView(imageUrl: office.photoURL, sizeImage: 120)
                    .padding(.top, 20)
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text(String.WordsToAskForADate)
                            .modifier(textStylePrincipal())
                    })
                    .modifier(buttonPrincipal(padding: 10.0, .principal, 10.0))
                    Spacer()
                }
                
                if !getImageSliderArray().isEmpty {
                    VStack {
                        Text(String.WordOffice)
                            .foregroundColor(Color(red: 0.51, green: 0.39, blue: 0.62))
                            .fontWeight(.bold)
                            .font(.title3)
                            .modifier(AligmentView(aligment: .leading))
                        ImageSliderView(images: getImageSliderArray(), cornerRadius: 20, heightImage: 200)
                    }
                }
                if !viewModel.chipsSpecialities.isEmpty {
                    VStack {
                        Text(String.WordSpecialities)
                            .foregroundColor(Color(red: 0.51, green: 0.39, blue: 0.62))
                            .fontWeight(.bold)
                            .font(.title3)
                            .modifier(AligmentView(aligment: .leading))

                        ChipContainerView(chipArray: $viewModel.chipsSpecialities, updateHeigh: { height in
                            if Int(self.heightFirstContainerChips) != Int(height) && Int(height) > Int(self.heightFirstContainerChips) {
                                self.heightFirstContainerChips = height
                            }
                        }, enableChangeColorOnSelect: false).frame(height: heightFirstContainerChips)
                    }
                }
            }.padding(.horizontal, 20)
        }
        .background(Color.background)
        .task {
            viewModel.setup(office)
        }
    }
    
    private func getImageSliderArray() -> [ImageSlider] {
        var array: [ImageSlider] = []
        
        office.imagesSlider?.forEach({ image in
            array.append(ImageSlider(image: image, type: .network))
        })
        
        return array
    }
}
