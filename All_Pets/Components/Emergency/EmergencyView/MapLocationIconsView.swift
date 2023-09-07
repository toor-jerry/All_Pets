//  MapLocationIconsView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 07/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct MapLocationIconsView: View {

    @StateObject var viewModel: EmergencyViewModel

    private let sizeIcons: CGFloat = 40
    private let cornerRadius: CGFloat = 10
    private let backgrounColor: Color = .gray.opacity(0.8)

    var body: some View {
        VStack {
            HStack {
                VStack {
                    VStack {
                        Text("Consultorio cercano")
                        Text(viewModel.office?.name ?? "")
                        Text("a \(viewModel.office?.distanceToUserLocation?.description ?? "") Mtrs.")
                            .font(.callout)
                            .foregroundColor(.black)
                            .modifier(AligmentView(aligment: .leading))
                    }
                    .padding()
                }
                .fontWeight(.bold)
                .clipShape(Rectangle())
                .background(backgrounColor)
                .cornerRadius(cornerRadius)

                Spacer()

                VStack {
                    Button(action: {
                        viewModel.userTrackingMode = viewModel.userTrackingMode == .follow ? .none : .follow
                    }, label: {
                        Image(systemName: viewModel.userTrackingMode == .follow ? "location.fill" : "location")
                            .resizable()
                            .frame(width: sizeIcons, height: sizeIcons)
                            .foregroundColor(.white)
                    })
                    .padding()
                }
                .clipShape(Rectangle())
                .background(backgrounColor)
                .cornerRadius(cornerRadius)
                .frame(width: 60, height: 60)
            }
            Spacer()
        }
        .padding(.top, 40)
        .padding(20)
    }
}
