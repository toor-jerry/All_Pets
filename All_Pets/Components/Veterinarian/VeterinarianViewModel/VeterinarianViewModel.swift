//  VeterinarianViewModel.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 31/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit

final class VeterinarianViewModel: NSObject, ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var userHasLocation: Bool = false
    @Published var offices: [OfficeModel] = []
    
    let useCase: VeterianUseCaseProtocol
    
    private var userLocation: CLLocation?
    private let locationManager: CLLocationManager = .init()
    
    init(useCase: VeterianUseCaseProtocol) {
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
            
            self.offices = offices
            self.calculateNearestOffice()
        }, failure: { _ in
            
        }, completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        })
    }
    
    private func calculateNearestOffice() {
        guard let userLocation = userLocation, !offices.isEmpty else { return }
        
        let updatedOffices = offices.map { office -> OfficeModel in
            var mutableOffice = office
            let officeLocation = CLLocation(latitude: office.latitude ?? 0.0, longitude: office.length ?? 0.0)
            let distance = userLocation.distance(from: officeLocation)
            mutableOffice.distanceToUserLocation = Int(distance)
            return mutableOffice
        }
        
        self.setTheardMain {
            self.offices = updatedOffices
        }
    }
    
    private func checkUserAuthorization() {
        let status = locationManager.authorizationStatus
        switch status {
        case .authorized, .authorizedAlways, .authorizedWhenInUse:
            userHasLocation = true
            break
        case .denied, .notDetermined, .restricted:
            print("User no ha autorizado mostrar su localización")
            userHasLocation = false
        @unknown default:
            print("Unhandled state")
        }
    }
}

extension VeterinarianViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Data2 location: ", location)
        userLocation = .init(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        calculateNearestOffice()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserAuthorization()
    }
}
