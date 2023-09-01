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
    @Published var filterSector: [String] = []
    
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
        
        var sectorTmp: [String] = []
        
        let updatedOffices = offices.map { office -> OfficeModel in
            var mutableOffice = office
            let officeLocation = CLLocation(latitude: office.latitude ?? .zero, longitude: office.length ?? .zero)
            let distance = userLocation.distance(from: officeLocation)
            mutableOffice.distanceToUserLocation = Int(distance)
            sectorTmp.append(contentsOf: office.specializedSector ?? [])
            return mutableOffice
        }
        
        let sortedOffices = updatedOffices.sorted { $0.distanceToUserLocation ?? .zero < $1.distanceToUserLocation ?? .zero }
        
        let uniqueSortedSectors = Array(Set(sectorTmp))
            .sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
            .map { $0.capitalized }
        
        self.setTheardMain {
            self.offices = sortedOffices
            self.filterSector = uniqueSortedSectors
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
