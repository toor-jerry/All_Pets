//  Emergency.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 28/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct OfficeModel: Codable {
    var status: String?
    var hourEnd: String?
    var hourStart: String?
    var idOffice: String?
    var latitude: Double?
    var length: Double?
    var name: String?
    var medicalSpecialities: [String]?
    var specializedSector: [String]?
    var imagesSlider: [String]?
    var punctuation: Int?
    var address: String?
    var distanceToUserLocation: Int?
    var photoURL: String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case hourEnd = "HFin"
        case hourStart = "HInicio"
        case idOffice = "Id"
        case latitude = "Latitud"
        case length = "Longitud"
        case name = "Nombre"
        case medicalSpecialities = "medical_specialties"
        case specializedSector = "specialized_sector"
        case punctuation = "Puntuacion"
        case address = "direccion"
        case distanceToUserLocation = "distanceToUserLocation"
        case photoURL = "imgLogo"
        case imagesSlider = "imagenes"
    }
}
