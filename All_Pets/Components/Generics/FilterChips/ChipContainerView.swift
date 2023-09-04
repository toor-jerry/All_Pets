//  ChipContainerView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 03/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ChipContainerView: View {
    
    @Binding var chipArray: [ChipModel]
    
    var paddingChips: CGFloat = 10
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return GeometryReader { geo in
            ZStack(alignment: .topLeading, content: {
                ForEach(chipArray, id: \.id) { data in

                    ChipView(titleKey: data.titleKey, isSelected: data.isSelected, isSelectedChip: {
                        chipSelected(data.id)
                    }, systemImage: data.systemImage)

                    .padding(.all, paddingChips)
                    .alignmentGuide(.leading) { dimension in
                        if (abs(width - dimension.width) > geo.size.width) {
                            width = .zero
                            height -= dimension.height
                        }
                        let result = width
                        if data.id == chipArray.last!.id {
                            width = .zero
                        } else {
                            width -= dimension.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { dimension in
                        let result = height
                        if data.id == chipArray.last!.id {
                            height = .zero
                        }
                        return result
                    }
                }
            })
        }
    }

    private func chipSelected(_ index: UUID) {
        if let chipIndex = chipArray.firstIndex(where: { $0.id == index }) {
            var updatedChip = chipArray[chipIndex]
            updatedChip.isSelected.toggle()
            chipArray[chipIndex] = updatedChip
        }
    }
}

struct ChipContainerView_Previews: PreviewProvider {
    static var previews: some View {
        @State var array = [
            ChipModel(titleKey: "Heart", isSelected: false, systemImage: "heart.circle"),
            ChipModel(titleKey: "Folder", isSelected: true)
        ]
        ChipContainerView(chipArray: $array)
    }
}