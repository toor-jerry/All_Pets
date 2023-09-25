//  SessionInfoCustom.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

final class SessionInfo: ObservableObject {
    @Published var pets: [Pet] = []
    @Published var petSelected: Pet? = nil
}
