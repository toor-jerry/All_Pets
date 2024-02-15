//  HomeBottomSheetCell.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 31/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct HomeBottomSheetCell: View {

    var pet: Pet
    var isChecked: Bool

    var body: some View {
        HStack {

            if let imageUrl = pet.photoURL {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .modifier(imageSize())

                } placeholder: {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .modifier(imageSize())
                }
            } else {

                Image(pet.pet)
                    .resizable()
                    .modifier(imageSize())
            }

            Text(pet.name ?? "")
                .font(.title3)

            Spacer()

            if isChecked {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .modifier(imageSize(size: 20))
                    .foregroundColor(.green)
            }
        }
    }
}
