//  ForgotPasswordUseCase.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/02/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseAuth
import AllPetsNetworkProvider

protocol ForgotPasswordProtocol: AnyObject {
    
    func forgotPassword(email: String,
                        success: @escaping () -> Void,
                        error: @escaping (Error) -> Void,
                        completion: @escaping () -> Void)
}

final class ForgotPasswordUseCase: ForgotPasswordProtocol {
    
    func forgotPassword(email: String,
                        success: @escaping () -> Void,
                        error: @escaping (Error) -> Void,
                        completion: @escaping () -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { errorReq in
            if let _ = errorReq {
                error(NetworkingServerErrors.unknownError)
            } else {
                success()
            }
        }
        
        completion()
    }
}
