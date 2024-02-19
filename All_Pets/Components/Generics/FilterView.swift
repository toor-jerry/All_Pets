//  FilterView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 01/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    
    @State var showButtonFilter: Bool
    @State var backgroundColor: Color = Color(.background)
    @Binding var listSector: [FilterSector]
    @Binding var buttonFilterSelected: Bool
    @Binding var filterSelected: Bool
    @Binding var filterSectorSelected: Bool
    
    var body: some View {
        
        HStack {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(Array(listSector.enumerated()), id: \.1) { index, filter in
                        Button(action: {
                            filterSelect(index)
                        }, label: {
                            Text(filter.sector)
                                .modifier(textStylePrincipal(color: filter.isSelected ? .white : .black, setWidth: false, fontSize: .callout))
                        })
                        .modifier(buttonPrincipal(padding: 10, filter.isSelected ? Color(.bluePrincipal) : .white))
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
                        .modifier(buttonPrincipal(padding: 10,.white, 10))
                        .addVerifiedBadge(filterSelected)
                })
                .padding(.trailing, 20)
            }
        }
        .background(backgroundColor)
    }
    
    private func filterSelect(_ index: Int) {
        if let filter = listSector[safe: index] {
            listSector[index] = FilterSector(filter.sector, isSelected: !filter.isSelected)
        }
        filterSectorSelected = true
    }
}
