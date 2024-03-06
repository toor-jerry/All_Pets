//  Explore.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/10/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct BusinessModel: Codable {
    var accesories: Bool?
    var food: Bool?
    var articles: [String]?
    var categorie: [String]?
    var hourOpen: String?
    var hourClose: String?
    var images: [String]?
    var imgBanner: String?
    var latitude: Double?
    var length: Double?
    var name: String?
    var desserts: Bool?
    var status: String?

    enum CodingKeys: String, CodingKey {
        case categorie = "categoria"
        case hourOpen = "hora_Inicio"
        case hourClose = "hora_Fin"
        case accesories = "accesorios"
        case food = "alimentos"
        case desserts = "postres"
        case articles = "articulos"
        case latitude = "latitud"
        case length = "longitud"
        case name = "nombre"
        case images = "imagenes"
    }
}
