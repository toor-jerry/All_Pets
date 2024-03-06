//  ExploreCardCell.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 06/03/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import AllPetsCommons

struct ExploreCardCell: View {
    
    var business: BusinessModel
    private let heightImage: CGFloat = 80
    
    init(business: BusinessModel) {
        self.business = business
    }
    
    var body: some View {
        HStack {
            
            VeterianImageView(imageUrl: business.imgBanner)
            
            VStack(spacing: 10) {
                
                Text(business.name ?? "")
                    .fontWeight(.bold)
                    .foregroundColor(Color.purpleSecundary)
                    .font(.title3)
                    .modifier(GenAligmentView(aligment: .leading))
                
                Text("\("WordSchedule"): \(business.hourOpen ?? "") - \(business.hourClose ?? "")")
                    .font(.callout)
                    .foregroundColor(.black)
                    .modifier(GenAligmentView(aligment: .leading))
                
                Text("".getDistanceDescription(of:  business.distanceToUserLocation ?? .zero))
                    .font(.callout)
                    .foregroundColor(.black)
                    .modifier(GenAligmentView(aligment: .leading))
            }
            .padding(.bottom, 15)
        }
        .padding(10)
    }
}
