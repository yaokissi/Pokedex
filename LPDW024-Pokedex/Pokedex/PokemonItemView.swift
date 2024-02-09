//
//  pokemonItemView.swift
//  Pokedex
//
//  Created by Les Prodiges on 09/02/2024.
//

import SwiftUI

struct PokemonItemView: View {
    let urlString: String
    
    @State var pokemon: Pokemon?
    
    var imageUrl: URL? {
        guard let pokemon else { return .none }
        return URL(string: pokemon.sprites.front_default)
    }
    
    var body: some View {
        HStack {
            if let pokemon {
                if let imageUrl {
                    AsyncImage(url: imageUrl)
                        
                        .frame(width: 80, height: 80)
                        .font(.largeTitle)
                        .overlay(
                            Circle().stroke(Color.purple, lineWidth: 3)
                        )
                        .shadow(radius: 3)
                }
                 Text(pokemon.name)
            } else {
                ProgressView()
                Text("Loading…")
            }
        }
        .onAppear {
            Task {
                guard let url = URL(string: urlString) else {
                    print("Error with URL")
                    return
                }
                
                let (data, response) = try await URLSession.shared.data(from: url)
                
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    print("Error with request")
                    return
                }
                
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    self.pokemon = pokemon
               } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
}

//#Preview {
//    PokemonItemView()
//}
