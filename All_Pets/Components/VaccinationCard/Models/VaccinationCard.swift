//  VaccinationCard.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 25/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Firebase
import SwiftUI

enum VaccinationCardStatus: String {
    case current = "vigente"
    case pending = "pendiente"
    case overdue = "vencida"
}

extension VaccinationCardStatus {

    func getTextColor() -> Color {

        var color: Color

        switch self {
        case .current:
            color = Color(red: 0.53, green: 0.8, blue: 0.46)
        case .pending:
            color = .white
        case .overdue:
            color = Color(red: 0.84, green: 0.42, blue: 0.42)
        }

        return color
    }

    func getBackgroundColor() -> Color {

        var color: Color

        switch self {
        case .current:
            color = Color(red: 208, green: 236, blue: 200)
        case .pending:
            color = Color(red: 212, green: 210, blue: 210)
        case .overdue:
            color = Color(red: 255, green: 219, blue: 218)
        }

        return color
    }
}

struct VaccinationCardModel: Codable {

    var professionalLicense: String
    var vaccinationDate: Timestamp
    var status: String
    var vaccine: String

    enum CodingKeys: String, CodingKey {
        case professionalLicense = "PLicense"
        case vaccinationDate = "date"
        case status = "status"
        case vaccine = "vaccine"
    }

    func getDateWithFormat() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        return dateFormatterGet.string(from: vaccinationDate.dateValue())
    }

    func getStatus() -> VaccinationCardStatus? {
        return VaccinationCardStatus.init(rawValue: status)
    }
}

/*struct CiteModel: Codable {
 var day: Timestamp
 var idVet: String
 var patient: String
 var status: String
 var userId: String
 var reason: String?

 enum CodingKeys: String, CodingKey {
 case day = "day"
 case idVet = "idVeterinaria"
 case patient = "patient"
 case status = "status"
 case userId = "userId"
 case reason = "reason"
 }
 }
 */
