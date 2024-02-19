//  ListSearch.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ListSearch: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var itemSelected: String
    
    @State var searchText: String = ""
    @State var list: [String]
    @State var filteredList: [String] = []
    
    var body: some View {
        
        VStack {
            Divider()
                .background(Color(.backgroundPrincipal))
            List {
                
                ForEach(filteredList, id: \.self) { element in
                    Text(element)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .onTapGesture {
                            itemSelected = element
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .foregroundColor(.black)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
            }
            .scrollContentBackground(.hidden)
            .searchable(text: $searchText, prompt: "")
            .foregroundColor(.black)
            .onChange(of: searchText) { newValue in
                if newValue.isEmpty {
                    filteredList = list
                } else {
                    filteredList = list.filter { element in
                        element.localizedCaseInsensitiveContains(newValue)
                    }
                }
            }
            .onAppear {
                if itemSelected == String(localized: "MsgSelectTypePet") {
                    itemSelected = ""
                }
                
                filteredList = list
            }
        }
        .background(Color(.backgroundPrincipal))
    }
}

#Preview {
    VStack {
        let itemSelected: String = ""
        ListSearch(itemSelected: .constant(itemSelected), list: [])
    }
}
