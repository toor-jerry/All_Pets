//  VaccinationCellView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 26/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import AllPetsCommons

struct VaccinationCardCell: View {

    var card: VaccinationCardModel

    var body: some View {
        HStack {

            Image(systemName: getNameImgType())
                .resizable()
                .foregroundColor(.blue.opacity(0.5))
                .frame(width: 50, height: 50)
                .padding(5)
                .padding(.bottom, 20)

            VStack(spacing: 5) {
                HStack {
                    Text(card.vaccine)
                        .fontWeight(.bold)
                        .foregroundColor(Color(uiColor: UIColor(red: 0.71, green: 0.61, blue: 0.81, alpha: 1)))
                    Spacer()
                }

                HStack {
                    Text("MsgDate")

                    Text(card.getDateWithFormat())
                        .fontWeight(.bold)

                    Spacer()
                }

                HStack {
                    Text("MsgProfessionalLiscense")

                    Text(card.professionalLicense)
                        .fontWeight(.bold)

                    Spacer()
                }
                .padding(.bottom, 20)
            }

            VStack {
                Text(card.status.capitalized)
                    .foregroundColor(card.getStatus()?.getTextColor())
                    .fontWeight(.bold)
                    .padding(10)
                    .background(card.getStatus()?.getBackgroundColor())
                    .modifier(GenCornerRadiusStyle(radius: 18, corners: [.bottomLeft, .topRight]))
                    .modifier(GenShadowStyle())

                Spacer()
            }
        }
        .font(.footnote)
    }

    private func getNameImgType() -> String {
        var nameImage: String = "photo"

        if let type = card.getType() {
            switch type {
            case .medicine:
                nameImage = "pills.fill"
            case .vaccine:
                nameImage = "syringe"
            }
        }
        return nameImage
    }
}
