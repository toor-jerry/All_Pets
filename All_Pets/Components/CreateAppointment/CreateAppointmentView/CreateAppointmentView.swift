//  CreateAppointmentView.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 22/09/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
//import FirebaseFirestore.FIRTimestamp
//import FirebaseFirestore
import FirebaseFirestore
// TODO: mover esto a generico Timestamp(date: Date())
import AllPetsCommons

enum AppointmentCite {
    case today
    case any
}

struct CreateAppointmentView: View {

    @StateObject var viewModel = CreateAppointmentViewModel(useCase: CreateAppoimentUseCase())
    @State var office: OfficeModel
    @Binding var showCreateAppoiment: Bool
    @EnvironmentObject var sessionInfo: SessionInfo
    @State private var selectedDate: Date = Date()
    @State private var selectedHour: String = ""
    @State private var hours: [String] = []
    @State private var reason: String = ""
    private let imageSize: CGFloat = 60

    var body: some View {
        VStack {
            if viewModel.isLoading {
                Loader()
            } else {
                Text("WordsSelectThePatient")
                    .font(.title)
                    .padding(.top, 50)

                ScrollView(.horizontal) {
                    LazyHStack {
                        ImagesPet(imageSize: imageSize)
                            .padding(5)
                    }
                }
                .frame(height: imageSize + 60)

                Divider()
                DatePicker("WordsDateCite", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                    .onChange(of: selectedDate) { newValue in
                        let calendar = Calendar.current
                        let currentDate = calendar.dateComponents([.day, .month, .year], from: Date())
                        let selectedDateComponents = calendar.dateComponents([.day, .month, .year], from: newValue)

                        if currentDate == selectedDateComponents {
                            selectedHour = generateHourArray(type: .today)
                        } else {
                            selectedHour = generateHourArray(type: .any)
                        }
                    }

                Divider()
                TextField("WordsSelectTheReason", text: $reason)
                    .padding()
                    .modifier(GenInputStylePrincipal())
                    .keyboardType(.asciiCapable)
                    .foregroundColor(.black)

                if !hours.isEmpty {
                    Divider()
                    HStack {
                        Text("WordsSelectSchedule")
                        Picker("WordsSelectSchedule", selection: $selectedHour) {
                            ForEach(hours, id: \.self) { hour in
                                Text(hour)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }

                Button(action: {
                    if !reason.isEmpty {
                        var timestamp: Timestamp = Timestamp(date: Date())
                        if let date = setDateWithFormattedTime(formattedTime: selectedHour) {
                            timestamp = Timestamp(date: date)
                        }

                        let citeModel: CiteModel = CiteModel(day: timestamp, idVet: office.idOffice ?? "", patient: sessionInfo.petSelected?.id ?? "", status: "pendiente", reason: reason)
                        viewModel.createAppoiment(appoiment: citeModel, completion: {
                            self.showCreateAppoiment.toggle()
                        })
                    }
                }, label: {
                    Text("WordsSendRequest")
                        .modifier(GenTextStylePrincipal())
                })
                .modifier(GenButtonPrincipal(padding: 10.0, color: reason.isEmpty ? .gray.opacity(0.8) : Color.bluePrincipal, radius: 10.0))

                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .background(Color.backgroundPrincipal)
        .foregroundColor(.black)
        .onAppear {
            selectedHour = generateHourArray(type: .today)
        }
    }

    private func generateHourArray(type: AppointmentCite) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:00"
        var hourArray: [String] = []
        var currentDate: Date = Date()

        switch type {
        case .today:
            if var date = dateFormatter.date(from: dateFormatter.string(from: Date())) {
                currentDate = date.addHour()
            }
        case .any:
            if let hourStar = office.hourStart, let date = dateFormatter.date(from: hourStar) {
                currentDate = date
            }
        }

        if let endDateString = office.hourEnd,
           let endDate = dateFormatter.date(from: endDateString) {
            while currentDate <= endDate {
                dateFormatter.dateFormat = "h:00 a"
                let formattedTime = dateFormatter.string(from: currentDate)
                hourArray.append(formattedTime)
                currentDate = currentDate.addHour()
                dateFormatter.dateFormat = "HH:00"
            }
        }

        hours = hourArray
        return hourArray.first ?? ""
    }

    func setDateWithFormattedTime(formattedTime: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:00 a"

        guard let timeDate = dateFormatter.date(from: formattedTime) else {
            return nil
        }

        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: timeDate)

        return selectedDate.setHour(hour: hour)
    }
}

#Preview {
    CreateAppointmentView(office: OfficeModel(), showCreateAppoiment: .constant(false))
}

struct ImagesPet: View {

    @EnvironmentObject var sessionInfo: SessionInfo
    let imageSize: CGFloat

    var body: some View {

        ForEach(Array(sessionInfo.pets.enumerated()), id: \.element.id) { index, pet in

            VStack {
                if sessionInfo.petSelected?.id == pet.id {
                    Text("MsgSelected")
                        .foregroundStyle(Color.bluePrincipal)
                } else {
                    Text(" ")
                }

                if let imageUrl = sessionInfo.pets[safe: index]?.photoURL {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .modifier(GenProfileImage(size: imageSize))
                    } placeholder: {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .modifier(GenProfileImage(size: imageSize))
                    }
                } else {
                    Image(pet.pet)
                        .resizable()
                        .modifier(GenProfileImage(size: imageSize))
                }

                Text(pet.name ?? "")
                    .foregroundStyle(sessionInfo.petSelected?.id == pet.id ? Color.bluePrincipal: Color.limeGreen)
            }
        }
    }
}
