//  NetworkingProviderService.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 09/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class NetworkingProviderService: Fetcher {
    let session: GSSAPRMURLSessionProtocol
    let request: URLRequest

    init(with request: RequestType) {
        self.session = URLSession.shared
        self.request = request.getRequest()
    }

    func fetchData<T>(success: @escaping (T) -> Void,
                      failure : @escaping (Error) -> Void,
                      completion: @escaping () -> Void) where T : Decodable {

        let task = session.performDataTask(with: request) { (data, response, errorResponse) in

            if let errorResponse: Error = errorResponse {
                failure(errorResponse)
            } else {
                guard let data: Data = data else {
                    failure(NetworkingServerErrors.dataNotFound)
                    return
                }

                guard let _: HTTPURLResponse = response as? HTTPURLResponse else {
                    failure(NetworkingServerErrors.response)
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    success(decodedData)
                } catch {
                    failure(NetworkingClientErrors.decodingError)
                }
            }

            completion()
        }
        task.resume()
    }
}
