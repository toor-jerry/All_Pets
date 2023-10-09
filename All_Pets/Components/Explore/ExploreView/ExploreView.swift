//  ExploreView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/10/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ExploreView: View {

    @StateObject var viewModel = ExploreViewViewModel(useCase: ExploreViewUseCase())
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ExploreViewPreviews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}

