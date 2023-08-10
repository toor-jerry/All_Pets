//  Loader.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct Loader: View {
    var body: some View {
        ProgressView(String.MsgLoader)
            .scaleEffect(2)
    }
}
