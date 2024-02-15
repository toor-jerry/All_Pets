//  Fetcher.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol Fetcher {
    func fetchData<T: Decodable>(success: @escaping (_ result: T) -> Void,
                                 failure: @escaping (Error) -> Void,
                                 completion:  @escaping () -> Void)  where T: Decodable
}
