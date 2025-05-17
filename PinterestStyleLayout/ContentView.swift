//
//  ContentView.swift
//  PinterestStyleLayout
//
//  Created by Belkhadir Anas on 17/5/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            PinterestLayout {
                ForEach(mockMovies) { movie in
                    MovieCard(movie: movie)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
