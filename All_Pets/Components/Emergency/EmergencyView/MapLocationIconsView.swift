//  MapLocationIconsView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 07/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import MapKit

enum MapLocationIconsPadding {
    case large
    case zero
}

struct MapLocationIconsView: View {
    
    @State var userTrackingMode: MapUserTrackingMode
    var distanceToUserLocation: Int?
    let titleLocation: String?
    let mapLocationIconsPadding: MapLocationIconsPadding

    private let cornerRadius: CGFloat = 10
    private let backgrounColor: Color = .gray.opacity(0.8)
    
    var body: some View {
        VStack {
            HStack {
                if let titleLocation = titleLocation {
                    TitleMapIconsView(namePlace: titleLocation, distanceToUserLocation: distanceToUserLocation)
                        .background(backgrounColor)
                        .cornerRadius(cornerRadius)
                        .padding(.trailing, mapLocationIconsPadding == .large ? 60 : .zero)
                }
                
                ButtonLocationView(userTrackingMode: $userTrackingMode)
                    .background(backgrounColor)
                    .cornerRadius(cornerRadius)
            }
            Spacer()
        }
        .padding(.top, mapLocationIconsPadding == .large ? 40 : .zero)
        .padding(mapLocationIconsPadding == .large ? 20 : 10)
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
