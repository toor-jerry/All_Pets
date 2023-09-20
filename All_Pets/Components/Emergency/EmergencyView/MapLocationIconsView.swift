//  MapLocationIconsView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 07/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct MapLocationIconsView: View {

    // TODO: crearlo generico
    @StateObject var viewModel: EmergencyViewModel

    private let cornerRadius: CGFloat = 10
    private let backgrounColor: Color = .gray.opacity(0.8)

    var body: some View {
        VStack {
            HStack {
                if let office = viewModel.office {
                    TitleMaoIconsView(viewModel: viewModel, office: office)
                        .background(backgrounColor)
                        .cornerRadius(cornerRadius)
                        .padding(.trailing, 60)
                }

                ButtonLocationView(viewModel: viewModel)
                    .background(backgrounColor)
                    .cornerRadius(cornerRadius)
            }
            Spacer()
            Button(action: {

            }, label: {
                Text(String.MsgSendAlert)
                    .modifier(textStylePrincipal())
            })
            .modifier(buttonPrincipal(.red))
            .padding(.bottom, 80)
        }
        .padding(.top, 40)
        .padding(20)
    }
}

struct ButtonLocationView: View {

    @StateObject var viewModel: EmergencyViewModel
    private let sizeIcons: CGFloat = 30

    var body: some View {
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
        .frame(width: sizeIcons + 20, height: sizeIcons + 20)
    }
}

struct TitleMaoIconsView: View {

    @StateObject var viewModel: EmergencyViewModel
    let office: OfficeModel

    var body: some View {
        VStack {
            VStack {
                Text(String.WordsNearbyOffice)
                    .fontWeight(.regular)
                    .modifier(AligmentView(aligment: .leading))

                if let name = office.name {
                    Text("\"\(name)\"")
                }
                Text("".getDistanceDescription(of:  office.distanceToUserLocation ?? .zero))
                    .font(.callout)
                    .foregroundColor(.black)
                    .modifier(AligmentView(aligment: .leading))
            }
            .padding()
        }
        .fontWeight(.bold)
        .clipShape(Rectangle())
    }
}
