//  ListSearch.swift
//  All_Pets
//
//  Created by Gerardo Bautista Castañeda on 15/08/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct ListSearch: View {

    var body: some View {
        VStack {
            NavigationStack {
                List {
                    //                        ForEach(viewModel.result, id: \.id) { element in
                    //                            MoviesCell(title: element.title,
                    //                                       poster_path: element.poster_path, idMovie: element.id)
                    //                            .frame(height: 200)
                    //                        }
                    //                    }
                    //                    .refreshable {
                    //                        viewModel.getMovies()
                    //                    }
                    //                    .navigationTitle("PEliculas")
                    //                .searchable(text: $viewModel.searchText, prompt: "Buscar pelicula")
                    //                .onChange(of: viewModel.searchText) { newValue in
                    //
                    //                    if newValue.isEmpty {
                    //                        viewModel.getMovies()
                    //                    } else {
                    //                        viewModel.searchMovies(query: newValue)
                    //                    }
                    //
                    //                }
                    //                }
                    //            }
                    //
                    //        }
                    //        }
                }
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        ListSearch()
    }
}
