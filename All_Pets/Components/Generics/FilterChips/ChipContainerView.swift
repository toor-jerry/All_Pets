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
                ForEach(chipArray) { data in
                    
                    ChipView(titleKey: data.titleKey,
                             isSelected: data.isSelected, systemImage: data.systemImage)
                    
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
}

struct ChipContainerView_Previews: PreviewProvider {
    static var previews: some View {
        @State var array = [
            ChipModel(isSelected: false, systemImage: "heart.circle", titleKey: "Heart"),
            ChipModel(isSelected: false, systemImage: "folder.circle", titleKey: "Folder"),
            ChipModel(isSelected: false, systemImage: "pencil.and.outline", titleKey: "Pen"),
            ChipModel(isSelected: false, systemImage: "book.circle", titleKey: "Book"),
            ChipModel(isSelected: false, systemImage: "paperplane.circle", titleKey: "Paper Plain"),
            ChipModel(isSelected: false, systemImage: "opticaldiscdrive", titleKey: "Optical Drive"),
            ChipModel(isSelected: false, systemImage: "doc.circle", titleKey: "Documents")
        ]
        ChipContainerView(chipArray: $array)
    }
}
