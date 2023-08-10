//  ObservableObject+Extension.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

extension ObservableObject {

    func setTheardMain(work: @escaping () -> Void) {
        DispatchQueue.main.async {
            work()
        }
    }
}
