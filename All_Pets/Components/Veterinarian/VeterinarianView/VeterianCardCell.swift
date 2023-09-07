//  VeterianCardCell.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 01/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct VeterianCardCell: View {

    var office: OfficeModel
    private var pets: String = ""

    init(office: OfficeModel) {
        self.office = office
        self.pets = office.specializedSector?.formatArrayToString() ?? ""
    }

    var body: some View {
        HStack {

            VeterianImageView(imageUrl: office.photoURL)

            VStack(spacing: 10) {

                Text(office.name ?? "")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.51, green: 0.39, blue: 0.62))
                    .font(.title3)
                    .modifier(AligmentView(aligment: .leading))

                Text("\(String.WordPets): \(pets)")
                    .font(.callout)
                    .foregroundColor(.black)
                    .modifier(AligmentView(aligment: .leading))

                Text("a \(office.distanceToUserLocation?.description ?? "") Mtrs.")
                    .font(.callout)
                    .foregroundColor(.black)
                    .modifier(AligmentView(aligment: .leading))
            }
            .padding(.bottom, 15)
        }
        .padding(10)
    }
}
