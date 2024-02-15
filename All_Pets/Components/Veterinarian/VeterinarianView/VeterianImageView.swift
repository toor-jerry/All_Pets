//  VeterianImageView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 06/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct VeterianImageView: View {

    let imageUrl: String?
    var sizeImage: CGFloat

    init(imageUrl: String?, sizeImage: CGFloat = 60.0) {
        self.imageUrl = imageUrl
        self.sizeImage = sizeImage
    }

    var body: some View {
        if let imageUrl = imageUrl {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .modifier(imageSize(size: sizeImage))

            } placeholder: {
                Image(systemName: "photo.fill")
                    .resizable()
                    .modifier(imageSize(size: sizeImage))
            }
        } else {

            Image(.logoVeterian)
                .resizable()
                .modifier(imageSize(size: sizeImage))
        }
    }
}

