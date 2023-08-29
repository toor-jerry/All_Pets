//  EmergencyViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 28/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit

final class EmergencyViewModel: NSObject, ObservableObject {

    private struct Span {
        static let delta = 0.1
    }

    let useCase: EmergencyUseCaseProtocol

    @Published var isLoading: Bool = false
    @Published var office: OfficeModel = OfficeModel()
    @Published var officeLocation: MKCoordinateRegion = .init()
    @State var userLocation: MKCoordinateRegion = .init()
    private let locationManager: CLLocationManager = .init()

    init(useCase: EmergencyUseCaseProtocol) {
        self.useCase = useCase

        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }

    func getOffices() {
        isLoading = true
        useCase.getOffices(success: { offices in

        }, failure: { _ in

        }, completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        })
    }
}

extension EmergencyViewModel: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Data2 location: ", location)
        userLocation = .init(center: location.coordinate, span: .init(latitudeDelta: Span.delta, longitudeDelta: Span.delta))
    }
}
