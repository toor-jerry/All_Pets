//  VeterianCardCell.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 01/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct VeterianCardCell: View {

    var office: OfficeModel

    init(office: OfficeModel) {
        self.office = office
    }

    var body: some View {
        HStack {

            VeterianImageView(imageUrl: office.photoURL)

            VStack(spacing: 10) {

                Text(office.name ?? "")
                    .fontWeight(.bold)
                    .foregroundColor(.purpleSecundary)
                    .font(.title3)
                    .modifier(AligmentView(aligment: .leading))

                Text("\("WordSchedule"): \(office.hourStart ?? "") - \(office.hourEnd ?? "")")
                    .font(.callout)
                    .foregroundColor(.black)
                    .modifier(AligmentView(aligment: .leading))

                Text("".getDistanceDescription(of:  office.distanceToUserLocation ?? .zero))
                    .font(.callout)
                    .foregroundColor(.black)
                    .modifier(AligmentView(aligment: .leading))
            }
            .padding(.bottom, 15)
        }
        .padding(10)
    }
}
