//
//  ContentView.swift
//  Pokedex
//
//  Created by Etienne Vautherin on 08/02/2024.
//

import SwiftUI

struct ContentView: View {
    let model = ApiModel.shared
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(model.pokemonLinks, id: \.url) { link in
                    NavigationLink {
                        PokemonView(urlString: link.url)
                    } label: {
                        PokemonItemView(urlString: link.url)
                        HStack {
//                            if let imageUrl = URL(string: link.sprites.front_default) {
//                                AsyncImage(url: imageUrl)
//                                    .frame(width: 500, height: 500) // Ajustez la taille de l'image selon vos besoins
//                                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//                            }
//                            Text(link.name)
                        }
                    }
                }
            }
            .navigationTitle(Text("Pokedex"))
        } detail: {
            Text("Select an item")
        }
    }
}

