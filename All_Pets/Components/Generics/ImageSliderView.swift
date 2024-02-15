//  ImageSliderView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 06/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ImageSliderView: View {

    let heightImage: CGFloat
    let images: [ImageSlider]
    let cornerRadius: CGFloat

    init(images: [ImageSlider], cornerRadius: CGFloat = 20, heightImage: CGFloat = 150) {
        self.heightImage = heightImage
        self.images = images
        self.cornerRadius = cornerRadius
    }

    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State private var selection = 0

    var body: some View {

        ZStack {

            TabView(selection : $selection) {

                ForEach(.zero..<images.count) { index in

                    if let image = images[safe: index] {
                        switch image.type {
                        case .system:
                            Image(.logoVeterian)
                                .resizable()
                                .modifier(imageSize())
                        case .network:
                            AsyncImage(url: URL(string: image.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .scaledToFill()
                            }
                        }

                    }
                }

            }.tabViewStyle(.page)
                .cornerRadius(cornerRadius)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
                .onReceive(timer, perform: { _ in
                    withAnimation{
                        selection = selection < images.count ? selection + 1 : .zero
                    }
                })
                .frame(height: heightImage)
        }
    }
}

enum ImageSliderType {
    case system
    case network
}

struct ImageSlider {
    let image: String
    let type: ImageSliderType

    init(image: String, type: ImageSliderType) {
        self.image = image
        self.type = type
    }
}
