//
//  MovieCardView.swift
//  Practice
//
//  Created by Paul Ancajima on 11/16/23.
//

import SwiftUI

struct MovieCardView: View {
    @ObservedObject var movieViewModel: MovieViewModel
    @State var timeRemaining = 2
    let realMovie: RealMovie
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    var url: URL?
    
    init(realMovie: RealMovie, movieViewModel: MovieViewModel) {
        self.realMovie = realMovie
        self.movieViewModel = movieViewModel
        if let baseUrl = movieViewModel.userSession.userConfiguration?.images.base_url,
           let postPath = realMovie.poster_path,
           let posterSize = movieViewModel.userSession.userConfiguration?.images.poster_sizes.first {
            let urlString = baseUrl + "/\(posterSize)" + postPath
            self.url = URL(string: urlString)
        }
    }
    
    var body: some View {
        AsyncImage(url: self.url) { phase in
            switch phase {
            case .empty:
                if timeRemaining > 0 {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                        .onReceive(timer) { _ in
                            timeRemaining > 0 ? timeRemaining -= 1 : timer.upstream.connect().cancel()
                        }
                } else {
                    HStack(alignment: .center) {
                        Image(systemName: "wifi.slash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 5.0)
                            .stroke(.black, lineWidth: 2.0)
                    }
                    .padding([.top, .horizontal])
                        
                }
            case .success(let image):
                HStack {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                    Text(realMovie.title)
                        .padding([.top, .leading])
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 100)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke(.black, lineWidth: 2.0)
                }
                .padding([.top, .horizontal])
            case .failure(let error):
                Image(systemName: "wifi.slash")
                    .onAppear {
                        movieViewModel.errorShow = true
                        movieViewModel.errorString = error.localizedDescription
                    }
            @unknown default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MovieCardView(realMovie: Dummies.realMovie, movieViewModel: Dummies.movieViewModel)
}
