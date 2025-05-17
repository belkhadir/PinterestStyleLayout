//
//  MovieCard.swift
//  PinterestStyleLayout
//
//  Created by Belkhadir Anas on 17/5/2025.
//

import SwiftUI

// MARK: - Movie Model
struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageUrl: URL
    let year: Int
    let rating: Double
}

// MARK: - Mock Data
let mockMovies: [Movie] = [
    Movie(title: "Inception", description: "A thief who steals corporate secrets through the use of dream-sharing technology.", imageUrl: URL(string: "https://image.tmdb.org/t/p/w500/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg")!, year: 2010, rating: 8.8),
    Movie(title: "The Dark Knight", description: "Batman faces the Joker, a criminal mastermind who wants to create chaos.", imageUrl: URL(string: "https://image.tmdb.org/t/p/w500/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg")!, year: 2008, rating: 9.0),
    Movie(title: "Interstellar", description: "A team of explorers travel through a wormhole in space in an attempt to save humanity.", imageUrl: URL(string: "https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg")!, year: 2014, rating: 8.6),
    Movie(title: "Avengers: Endgame", description: "The Avengers assemble once more to reverse Thanos' actions and restore balance.", imageUrl: URL(string: "https://image.tmdb.org/t/p/w500/ulzhLuWrPK07P1YkdWQLZnQh1JL.jpg")!, year: 2019, rating: 8.4),
    Movie(title: "Parasite", description: "Greed and class discrimination threaten the newly formed symbiotic relationship.", imageUrl: URL(string: "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg")!, year: 2019, rating: 8.6),
]

// MARK: - Movie Card View
struct MovieCard: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: movie.imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                @unknown default:
                    EmptyView()
                }
            }
            
            Text(movie.title)
                .font(.headline)
                .lineLimit(1)
            
            Text(movie.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            HStack {
                Text("Year: \(movie.year)")
                Spacer()
                Text("⭐️ \(String(format: "%.1f", movie.rating))")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}
