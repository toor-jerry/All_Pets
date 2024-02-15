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

    func formatArrayToString() -> String {
        guard let array = self as? [String] else { return "" }
        switch array.count {
        case 0:
            return ""
        case 1:
            return array.first!.capitalized
        case 2:
            return "\(array[0].capitalized) \("WordJoin") \(array[1].capitalized)"
        default:
            let lastElement = array.last!.capitalized
            let firstElements = array.dropLast().map { $0.capitalized }.joined(separator: ", ")
            return "\(firstElements), \("WordJoin") \(lastElement)"
        }
    }
}
