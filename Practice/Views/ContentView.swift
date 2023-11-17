//
//  ContentView.swift
//  Practice
//
//  Created by Paul Ancajima on 11/15/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject var movieViewModel: MovieViewModel
    @State var movieTitle: String = ""
    
    init(userSession: UserSession) {
        _movieViewModel = StateObject(wrappedValue: MovieViewModel(userSession: userSession, networkService: NetworkService()))
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            SearchView(movieViewModel: movieViewModel, movieTitle: $movieTitle)
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(movieViewModel.movies, id: \.id) { movie in
                        MovieCardView(realMovie: movie, movieViewModel: movieViewModel)
                    }
                }
                Spacer()
            }
            .scrollIndicators(.hidden)
            .alert("Error", isPresented: $movieViewModel.errorShow) {
                
            } message: {
                Text(movieViewModel.errorString)
            }
        }
    }
}


#Preview {
    ContentView(userSession: UserSession())
}
