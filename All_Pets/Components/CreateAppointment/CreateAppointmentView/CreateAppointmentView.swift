//  CreateAppointmentView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 22/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct CreateAppointmentView: View {
    
    //    @StateObject var viewModel = CreateAppointmentViewViewModel(useCase: CreateAppointmentViewUseCase())
    @State var office: OfficeModel
    @EnvironmentObject var sessionInfo: SessionInfo
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = {
        let calendar = Calendar.current
        var date = calendar.date(byAdding: .hour, value: 1, to: Date())!
        date = calendar.date(bySettingHour: calendar.component(.hour, from: date), minute: .zero, second: .zero, of: date)!
        return date
    }()
    
    private let imageSize: CGFloat = 60
    
    var body: some View {
        VStack {
            
            Text("\(String.MsgHello)")
                .font(.title)
                .padding(.top, 50)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ImagesPet(imageSize: imageSize)
                        .padding(5)
                }
                
                DatePicker(String.WordsDateCite, selection: $selectedDate, in: Date()..., displayedComponents: .date)
                    .onChange(of: selectedDate) { newValue in
                        let calendar = Calendar.current
                        let currentDate = calendar.dateComponents([.day, .month, .year], from: Date())
                        let selectedDateComponents = calendar.dateComponents([.day, .month, .year], from: newValue)
                        
                        if currentDate == selectedDateComponents {
                            var date = calendar.date(byAdding: .hour, value: 1, to: Date())!
                            date = calendar.date(bySettingHour: calendar.component(.hour, from: date), minute: .zero, second: .zero, of: date)!
                            selectedTime = date
                        } else {
                            
                        }
                    }
                
                DatePicker(String.WordsSelectSchedule, selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .onChange(of: selectedTime) { newValue in
                        let calendar = Calendar.current
                        selectedTime = calendar.date(bySettingHour: calendar.component(.hour, from: newValue), minute: .zero, second: .zero, of: newValue)!
                    }
            }
            //            .frame(height: imageSize + 40)
            .padding(.horizontal, 20)
            Spacer()
        }
        .background(Color.background)
        .foregroundColor(.black)
    }
}

#Preview {
    CreateAppointmentView(office: OfficeModel())
}

struct ImagesPet: View {
    
    @EnvironmentObject var sessionInfo: SessionInfo
    let imageSize: CGFloat
    
    var body: some View {
        ForEach(Array(sessionInfo.pets.enumerated()), id: \.1) { index, pet in
            
            VStack {
                if sessionInfo.petSelected?.id == pet.id {
                    Text(String.MsgSelected)
                        .foregroundStyle(Color.principal)
                } else {
                    Text(" ")
                }
                
                if let imageUrl = sessionInfo.pets[safe: index]?.photoURL {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .modifier(profileImage(size: imageSize))
                    } placeholder: {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .modifier(profileImage(size: imageSize))
                    }
                } else {
                    Image(pet.pet)
                        .resizable()
                        .modifier(profileImage(size: imageSize))
                }
                
                Text(pet.name ?? "")
                    .foregroundStyle(sessionInfo.petSelected?.id == pet.id ? Color.principal: Color.limeGreen)
            }
        }
    }
}
