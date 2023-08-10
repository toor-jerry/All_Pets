//  Array+Extension.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return (index < count && index >= 0) ? self[index] : nil
    }
}
