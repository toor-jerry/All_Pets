//  NetworkingClientErrors.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

enum NetworkingClientErrors: Error {
    case invalidURL
    case decodingError
    case lostReferenceSelf
    case requestInvalid
}
