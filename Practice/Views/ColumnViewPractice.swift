//
//  ColumnViewPractice.swift
//  Practice
//
//  Created by Paul Ancajima on 11/16/23.
//

import SwiftUI

struct ColumnViewPractice: View {
    @ObservedObject var movieViewModel: MovieViewModel
    
    var columns: [GridItem] = [.init(.flexible(minimum: 100, maximum: 200)),
                               .init(.flexible(minimum: 100, maximum: 200))]
    
    init(movieViewModel: MovieViewModel) {
        self.movieViewModel = movieViewModel
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(movieViewModel.movies, id: \.id) { movie in
                    MovieCardView(realMovie: movie, movieViewModel: movieViewModel)
                        .frame(height: 100)
                }
            }
        }
    }
}

#Preview {
    ColumnViewPractice(movieViewModel: MovieViewModel(userSession: UserSession(), networkService: NetworkService()))
}
