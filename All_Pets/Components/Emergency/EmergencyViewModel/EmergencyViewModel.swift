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
        static let delta = 0.09
    }
    
    let useCase: EmergencyUseCaseProtocol
    
    @Published var isLoading: Bool = false
    @Published var userHasLocation: Bool = false
    @Published var officeCoordinates: MKCoordinateRegion = .init()
    @Published var mapPins: [MapViewPin] = []
    private var offices: [OfficeModel] = []
    
    private var userLocation: CLLocation?
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
        
        var closestOffice: OfficeModel?
        var shortestDistance: CLLocationDistance = .greatestFiniteMagnitude
        
        for office in offices {
            let officeLocation = CLLocation(latitude: office.latitude ?? .zero, longitude: office.length ?? .zero)
            let distance = userLocation.distance(from: officeLocation)
            
            if distance < shortestDistance {
                shortestDistance = distance
                closestOffice = office
            }
        }
        
        self.setTheardMain {
            if let closestOffice = closestOffice,
               let lattitud = closestOffice.latitude,
               let longitude = closestOffice.length {
                self.mapPins = []
                self.officeCoordinates = .init(center: CLLocationCoordinate2D(latitude: lattitud, longitude: longitude), span: .init(latitudeDelta: Span.delta, longitudeDelta: Span.delta))
                self.mapPins.append(MapViewPin(coordinate: .init(latitude: lattitud, longitude: longitude), title: closestOffice.name ?? "", subtitle: closestOffice.address ?? ""))
            }
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

extension EmergencyViewModel: CLLocationManagerDelegate {
    
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
