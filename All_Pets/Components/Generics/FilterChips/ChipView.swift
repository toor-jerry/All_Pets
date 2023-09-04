//  ChipView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 03/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ChipView: View {

    let titleKey: LocalizedStringKey
    let systemImage: String?
    @State var isSelected: Bool

    init(titleKey: LocalizedStringKey, isSelected: Bool, systemImage: String? = nil) {
        self.titleKey = titleKey
        self.isSelected = isSelected
        self.systemImage = systemImage
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
            isSelected.toggle()
        }
    }
}

struct ChipView_Previews: PreviewProvider {
    static var previews: some View {
        ChipView(titleKey: "Title", isSelected: false, systemImage: "heart.circle")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
