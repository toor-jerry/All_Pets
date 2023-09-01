//  UserHasLocation.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 31/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct UserHasLocationView: View {

    var body: some View {
        VStack {
            Spacer()
            Text(String.MsgNoLocalization)
                .foregroundColor(.black)
                .bold()
                .padding(.bottom, 15)

            HStack {
                Spacer()
                Link(String.MsgAceptLocalization, destination: URL(string: UIApplication.openSettingsURLString)!)
                Spacer()
            }
            Spacer()
        }
        .font(.title3)
    }
}
