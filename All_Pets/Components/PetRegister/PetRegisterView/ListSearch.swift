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
                .background(Color.background)
            List {

                    ForEach(filteredList, id: \.self) { element in
                        Text(element)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .onTapGesture {
                                itemSelected = element
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                }
                .searchable(text: $searchText, prompt: "")
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
                    if itemSelected == String.MsgSelectTypePet {
                        itemSelected = ""
                    }

                    filteredList = list
                }
            }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        let itemSelected: String = ""
        ListSearch(itemSelected: .constant(itemSelected), list: [])
    }
}