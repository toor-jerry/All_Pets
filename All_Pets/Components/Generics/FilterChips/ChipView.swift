//  ChipView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 03/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ChipView: View {

    let titleKey: String
    let systemImage: String?
    @State var isSelected: Bool
    let isSelectedChip: () -> Void

    init(titleKey: String, isSelected: Bool, isSelectedChip: @escaping () -> Void, systemImage: String? = nil) {
        self.titleKey = titleKey
        self.systemImage = systemImage
        self.isSelected = isSelected
        self.isSelectedChip = isSelectedChip
    }

    var body: some View {
        HStack(spacing: 4) {
            if let systemImage = systemImage {
                Image(systemName: systemImage).font(.body)
            }

            Text(titleKey).font(.body).lineLimit(1)
        }
        .foregroundColor(isSelected ? .white : .black)
        .fontWeight(.bold)
        .modifier(buttonPrincipal(padding: 10, isSelected ? .principal : .white))
        .onTapGesture {
            isSelectedChip()
            isSelected.toggle()
        }
    }
}

struct ChipView_Previews: PreviewProvider {
    static var previews: some View {
        ChipView(titleKey: "Title", isSelected: false, isSelectedChip: {

        })
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

//struct ChipView_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var isSelected: Bool = false
//        ChipView(titleKey: "Title", systemImage: "heart.circle", isSelected: $isSelected)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
