//  MapViewPin.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 30/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import CoreLocation

struct MapViewPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
    let subtitle: String
}
