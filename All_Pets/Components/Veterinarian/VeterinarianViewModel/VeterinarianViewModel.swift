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
    @Published var showFilterBottomSheet: Bool = false
    @Published var filterChipsSelected: Bool = false
    @Published var filterSectorSelected: Bool = false
    @Published var filterSector: [FilterSector] = [] {
        didSet {
            if !showFilterBottomSheet {
                selectChipsByFilter()
            }
            if filterSectorSelected {
                filterOfficesBySections()
            }
        }
    }

    @Published var chipsSector: [ChipModel] = [] {
        didSet {
            if showFilterBottomSheet {
                selectFilterByChips()
            }
        }
    }

    @Published var chipsSpecialities: [ChipModel] = []

    private var officesBack: [OfficeModel] = []
    private let wordAllSectors: String = "todos"
    
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
            self.officesBack = offices
            self.calculateNearestOffice()
        }, failure: { _ in
        }, completion: {
            self.setTheardMain {
                self.isLoading = false
            }
        })
    }
    
    private func calculateNearestOffice() {
        // TODO: refactor
        guard let userLocation = userLocation, !offices.isEmpty else { return }

        var specialities: [String] = []
        var sectors: [String] = []

        let updatedOffices = offices.map { office -> OfficeModel in
            var mutableOffice = office
            let officeLocation = CLLocation(latitude: office.latitude ?? .zero, longitude: office.length ?? .zero)
            let distance = userLocation.distance(from: officeLocation)
            mutableOffice.distanceToUserLocation = Int(distance)
            specialities.append(contentsOf: office.medicalSpecialities ?? [])
            sectors.append(contentsOf: office.specializedSector ?? [])
            return mutableOffice
        }
        
        let sortedOffices = updatedOffices.sorted { $0.distanceToUserLocation ?? .zero < $1.distanceToUserLocation ?? .zero }

        var specialitiesModelTmp: [ChipModel] = []
        specialities.sorted().forEach { specialitie in
            specialitiesModelTmp.append(ChipModel(titleKey: specialitie.capitalizingFirstLetter()))
        }

        // TODO: refactorizar
        var sectorsModelTmp: [ChipModel] = []
        var filterSectorsModelTmp: [FilterSector] = []
        Set(sectors).sorted().forEach { sector in
            sectorsModelTmp.append(ChipModel(titleKey: sector.capitalizingFirstLetter()))
            filterSectorsModelTmp.append(FilterSector(sector.capitalizingFirstLetter()))
        }

        self.setTheardMain {
            self.officesBack = sortedOffices
            self.offices = sortedOffices
            self.chipsSpecialities = specialitiesModelTmp
            self.chipsSector = sectorsModelTmp
            self.filterSector = Array(filterSectorsModelTmp.prefix(3))
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

    func filterByChips() {
        isLoading.toggle()

        if !existFilterSelected() {
            setTheardMain {
                self.offices = self.officesBack
                self.isLoading.toggle()
                self.showFilterBottomSheet = false
            }
            return
        }

        filterOfficesByChipSpecialities()
        filterOfficesByChipSections()

        setTheardMain {
            self.isLoading.toggle()
            self.showFilterBottomSheet = false
        }
    }

    private func existFilterSelected() -> Bool {
        filterChipsSelected = chipsSector.contains { $0.isSelected } || chipsSpecialities.contains { $0.isSelected }
        return chipsSector.contains { $0.isSelected } || chipsSpecialities.contains { $0.isSelected } || filterSector.contains { $0.isSelected }
    }

    func selectChipsByFilter() {
        // TODO: refactor this code
        filterSector.forEach { filter in
            if let chipIndex = chipsSector.firstIndex(where: { $0.titleKey.lowercased() == filter.sector.lowercased() }) {
                var updatedChip = chipsSector[chipIndex]
                updatedChip.isSelected = filter.isSelected
                chipsSector[chipIndex] = updatedChip
            }
        }
    }

    private func selectFilterByChips() {
        // TODO: refactor this code
        chipsSector.forEach { chip in
            if let filterIndex = filterSector.firstIndex(where: { $0.sector.lowercased() == chip.titleKey.lowercased() }) {
                var updatedFilter = filterSector[filterIndex]
                updatedFilter.isSelected = chip.isSelected
                filterSector[filterIndex] = updatedFilter
            }
        }
    }

    private func filterOfficesBySections() {
        isLoading.toggle()

        if !existFilterSelected() {
            setTheardMain {
                self.offices = self.officesBack
                self.isLoading.toggle()
            }
            return
        }

        let selectedSectors = Set(filterSector.filter { $0.isSelected }.map { $0.sector.lowercased() })

        let filteredOffices = offices.filter { office in
            if let specializedSectors = office.specializedSector {
                if specializedSectors.contains(wordAllSectors) {
                    return true
                }
                return !selectedSectors.isDisjoint(with: specializedSectors.map { $0.lowercased() })
            }
            return false
        }

        setTheardMain {
            self.offices = filteredOffices
            self.isLoading.toggle()
        }
    }

    private func filterOfficesByChipSections() {

        let selectedSectors = Set(chipsSector.filter { $0.isSelected }.map { $0.titleKey.lowercased() })

        let filteredOffices = offices.filter { office in
            if let specializedSectors = office.specializedSector {
                if specializedSectors.contains(wordAllSectors) {
                    return true
                }
                return !selectedSectors.isDisjoint(with: specializedSectors.map { $0.lowercased() })
            }
            return false
        }

        setTheardMain {
            self.offices = filteredOffices
        }
    }

    private func filterOfficesByChipSpecialities() {

        let selectedSpecialities = Set(chipsSpecialities.filter { $0.isSelected }.map { $0.titleKey.lowercased() })

        let filteredOffices = offices.filter { office in
            if let medicalSpecialities = office.medicalSpecialities {
                if medicalSpecialities.contains(wordAllSectors) {
                    return true
                }
                return !selectedSpecialities.isDisjoint(with: medicalSpecialities.map { $0.lowercased() })
            }
            return false
        }

        setTheardMain {
            self.offices = filteredOffices
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
