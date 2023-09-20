//  MapLocationIconsView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 07/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import MapKit

struct MapLocationIconsView: View {

    // TODO: crearlo generico
    @StateObject var viewModel: EmergencyViewModel

    private let cornerRadius: CGFloat = 10
    private let backgrounColor: Color = .gray.opacity(0.8)

    var body: some View {
        VStack {
            HStack {
                if let office = viewModel.office {
                    TitleMapIconsView(namePlace: office.name, distanceToUserLocation: office.distanceToUserLocation)
                        .background(backgrounColor)
                        .cornerRadius(cornerRadius)
                        .padding(.trailing, 60)
                }

                ButtonLocationView(userTrackingMode: $viewModel.userTrackingMode)
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

    @Binding var userTrackingMode: MapUserTrackingMode
    private let sizeIcons: CGFloat = 30

    var body: some View {
        VStack {
            Button(action: {
                userTrackingMode = userTrackingMode == .follow ? .none : .follow
            }, label: {
                Image(systemName: userTrackingMode == .follow ? "location.fill" : "location")
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

struct TitleMapIconsView: View {

    let namePlace: String?
    let distanceToUserLocation: Int?

    var body: some View {
        VStack {
            VStack {
                Text(String.WordsNearbyOffice)
                    .fontWeight(.regular)
                    .modifier(AligmentView(aligment: .leading))

                if let namePlace = namePlace {
                    Text("\"\(namePlace)\"")
                }
                Text("".getDistanceDescription(of:  distanceToUserLocation ?? .zero))
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
