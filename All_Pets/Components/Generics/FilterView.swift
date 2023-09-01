//  FilterView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 01/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    
    @State var listSector: [String]
    @State var showButtonFilter: Bool
    @State var backgroundColor: Color = Color.background
    @Binding var sectorSelected: Int
    @Binding var buttonFilterSelected: Bool

    var body: some View {

        HStack {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(Array(listSector.enumerated()), id: \.1) { index, filter in
                        Button(action: {
                            sectorSelected = index
                        }, label: {
                            Text(filter)
                                .modifier(textStylePrincipal(color: .black, setWidth: false, fontSize: .callout))
                        })
                        .modifier(buttonPrincipal(padding: 10, .white))
                    }
                    .padding(5)
                }
                .frame(height: 50)
            }
            .padding(.horizontal, 20)

            if showButtonFilter {
                Spacer()

                Button(action: {
                    buttonFilterSelected.toggle()
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .modifier(buttonPrincipal(padding: 10, .white, 10))
                })
                .padding(.trailing, 20)
            }
        }
        .background(backgroundColor)
    }
}

struct FilterViewPreviews: PreviewProvider {
    static var previews: some View {
        FilterView(listSector: ["Gatos", "Perros", "Tortugas"], showButtonFilter: true, sectorSelected: .constant(.zero), buttonFilterSelected: .constant(true))
    }
}
