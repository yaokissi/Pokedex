//
//  PokemonView.swift
//  Pokedex
//
//  Created by Etienne Vautherin on 08/02/2024.
//

import SwiftUI

struct PokemonView: View {
    let urlString: String
    
    @State private var pokemon: Pokemon?
    
    var imageUrl: URL? {
        guard let pokemon = pokemon else { return nil }
        return URL(string: pokemon.sprites.front_default)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.orange)
                .shadow(radius: 50)
            
            VStack {
                if let imageUrl = imageUrl {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 150)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 150)
                        case .empty:
                            ProgressView()
                        @unknown default:
                            Text("Unknown AsyncImage phase")
                        }
                    }
                } else {
                    ProgressView()
                }
                
                if let pokemon = pokemon {
                    Text(pokemon.name)
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                }
            }
        }
        .padding()
        .onAppear {
            Task {
                guard let url = URL(string: urlString) else {
                    print("Error with URL")
                    return
                }
                
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    self.pokemon = pokemon
               } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    PokemonView(urlString: "https://pokeapi.co/api/v2/pokemon/1/")
}
