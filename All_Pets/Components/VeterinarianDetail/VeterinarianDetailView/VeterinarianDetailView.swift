//  VeterinarianDetailView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 06/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import MapKit

struct MapData {
    @State var userHasLocation: Bool
    @State var userTrackingMode: MapUserTrackingMode
    @State var pointCoordinates: MKCoordinateRegion
    @State var distanceToUserLocation: Int?
    let titleLocation: String?
}

struct VeterinarianDetailView: View {
    
    @EnvironmentObject var sessionInfo: SessionInfo
    // TODO: crear una estructura para manejar ubicaciones
    @State var office: OfficeModel
    @State var mapData: MapData
    @State var mapPins: [MapViewPin]
    
    @State private var heightFirstContainerChips: CGFloat = .zero
    @State private var heightSecondContainerChips: CGFloat = .zero
    @StateObject private var viewModel = VeterinarianDetailViewModel()
    
    @State var showCreateAppoiment = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VeterianImageView(imageUrl: office.photoURL, sizeImage: 120)
                    .padding(.top, 20)
                
                HStack {
                    Spacer()
                    Button(action: {
                        showCreateAppoiment.toggle()
                    }, label: {
                        Text("WordsToAskForADate")
                            .modifier(textStylePrincipal())
                    })
                    .modifier(buttonPrincipal(padding: 10.0, Color(.bluePrincipal), 10.0))
                    Spacer()
                }
                
                if !getImageSliderArray().isEmpty {
                    VStack {
                        Text("WordOffice")
                            .foregroundColor(Color(.purpleSecundary))
                            .fontWeight(.bold)
                            .font(.title3)
                            .modifier(AligmentView(aligment: .leading))
                        ImageSliderView(images: getImageSliderArray(), cornerRadius: 20, heightImage: 200)
                    }
                }
                if !viewModel.chipsSpecialities.isEmpty {
                    VStack {
                        Text("WordSpecialities")
                            .foregroundColor(Color(.purpleSecundary))
                            .fontWeight(.bold)
                            .font(.title3)
                            .modifier(AligmentView(aligment: .leading))
                        
                        ChipContainerView(chipArray: $viewModel.chipsSpecialities, updateHeigh: { height in
                            if Int(self.heightFirstContainerChips) != Int(height) && Int(height) > Int(self.heightFirstContainerChips) {
                                self.heightFirstContainerChips = height
                            }
                        }, enableChangeColorOnSelect: false).frame(height: heightFirstContainerChips)
                    }
                }
                
                if !viewModel.chipsSectors.isEmpty {
                    VStack {
                        Text("WordsTheyServe")
                            .foregroundColor(Color(.purpleSecundary))
                            .fontWeight(.bold)
                            .font(.title3)
                            .modifier(AligmentView(aligment: .leading))
                        
                        ChipContainerView(chipArray: $viewModel.chipsSectors, updateHeigh: { height in
                            if Int(self.heightSecondContainerChips) != Int(height) && Int(height) > Int(self.heightSecondContainerChips) {
                                self.heightSecondContainerChips = height
                            }
                        }, enableChangeColorOnSelect: false).frame(height: heightSecondContainerChips)
                    }
                }
                
                if let phoneNumber = office.phoneNumber,
                   !phoneNumber.isEmpty {
                    VStack(spacing: 20) {
                        Text("WordContact")
                            .foregroundColor(Color(.purpleSecundary))
                            .modifier(AligmentView(aligment: .leading))
                        
                        HStack {
                            Text("\("WordNumber"): ")
                                .foregroundColor(.black)
                            Button(action: {
                                guard let phoneNumber = office.phoneNumber,
                                      let url = URL(string: "tel://\(phoneNumber)") else {
                                    return
                                }
                                UIApplication.shared.open(url)
                            }, label: {
                                Text("\(office.phoneNumber ?? "")")
                                    .foregroundColor(Color(.limeGreen))
                            })
                            Spacer()
                        }
                    }.font(.title3).fontWeight(.bold)
                }
                
                if mapData.userHasLocation {
                    ZStack {
                        Map(coordinateRegion: $mapData.pointCoordinates, showsUserLocation: true, userTrackingMode: .constant(mapData.userTrackingMode), annotationItems: mapPins) { pin in
                            
                            MapMarker(coordinate: pin.coordinate)
                        }
                        
                        MapLocationIconsView(userTrackingMode: mapData.userTrackingMode, distanceToUserLocation: mapData.distanceToUserLocation, titleLocation: mapData.titleLocation, mapLocationIconsPadding: .zero)
                    }
                    .frame(height: 300)
                } else {
                    UserHasLocationView()
                }
            }.padding(.horizontal, 20).padding(.bottom, 40)
        }
        .task {
            viewModel.setup(office)
        }
        .sheet(isPresented: $showCreateAppoiment) {
            CreateAppointmentView(office: office, showCreateAppoiment: $showCreateAppoiment)
                .presentationDetents([.large])
        }
        .background(Color(.backgroundPrincipal))
    }
    
    private func getImageSliderArray() -> [ImageSlider] {
        var array: [ImageSlider] = []
        
        office.imagesSlider?.forEach({ image in
            array.append(ImageSlider(image: image, type: .network))
        })
        
        return array
    }
}
