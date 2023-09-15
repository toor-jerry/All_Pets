//  String+Extension.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

extension String {

    func getDistanceDescription(of distance: Int) -> String {
        var distanceOnKm: Float = Float(distance)
        var distanceMetrics: String = "Mtrs."

        if distanceOnKm >= 1000 {
            distanceOnKm = Float(distance / 1000)
            distanceMetrics = "KMs."
        }

        return "a \(distanceOnKm.description) \(distanceMetrics)"
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
