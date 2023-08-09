//  NetworkingServerErrors.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

enum GSSANetworkingServerErrors: Error {
    case internalServerError
    case dataNotFound
    case unknownError
    case response
    case attemptLimitExceeded
    case emptyDataAttribute
}
