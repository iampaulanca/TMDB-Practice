//
//  SearchView.swift
//  Practice
//
//  Created by Paul Ancajima on 11/16/23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var movieViewModel: MovieViewModel
    @Binding var movieTitle: String
    var body: some View {
        HStack {
            TextField("Seach For Movie", text: $movieTitle)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.blue, lineWidth: 2.0)
                }
                .padding()
            Button(action: {
                Task {
                    await movieViewModel.fetchMovies(title: movieTitle)
                }
            }, label: {
                Text("Search")
            })
            .foregroundStyle(.white)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 5.0)
                    .fill(.blue)
            }
            .padding(.trailing)
            
        }
    }
}

#Preview {
    SearchView(movieViewModel: Dummies.movieViewModel, movieTitle: .constant(""))
}
