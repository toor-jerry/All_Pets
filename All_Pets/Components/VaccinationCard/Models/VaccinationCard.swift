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

enum VaccinationCardType: String {
    case vaccine = "vacuna"
    case medicine = "medicina"
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
            color = Color(uiColor: UIColor(red: 0.81, green: 0.93, blue: 0.78, alpha: 1))
        case .pending:
            color = Color(uiColor: UIColor(red: 1, green: 0.85, blue: 0.85, alpha: 1))
        case .overdue:
            color = Color(uiColor: UIColor(red: 0.83, green: 0.82, blue: 0.82, alpha: 1))
        }

        return color
    }
}

struct VaccinationCardModel: Codable {

    var professionalLicense: String
    var vaccinationDate: Timestamp
    var status: String
    var vaccine: String
    var type: String?

    enum CodingKeys: String, CodingKey {
        case professionalLicense = "PLicense"
        case vaccinationDate = "date"
        case status = "status"
        case vaccine = "vaccine"
        case type = "type"
    }

    func getDateWithFormat() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        return dateFormatterGet.string(from: vaccinationDate.dateValue())
    }

    func getStatus() -> VaccinationCardStatus? {
        return VaccinationCardStatus.init(rawValue: status)
    }

    func getType() -> VaccinationCardType? {
        return VaccinationCardType.init(rawValue: type ?? "")
    }
}
