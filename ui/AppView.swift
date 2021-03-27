//
//  AppView.swift
//  Adoptable
//
//  Created by Rowan Hall on 8/30/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
    var body: some View {
        TabView {
            NavigationView {
                AnimalListView(arguments: NearbyAnimalArguments(location: "30308", animal: nil, size: nil, age: nil, sex: nil, breed: nil))
                    .navigationBarTitle("Animals")
            }.tabItem {
                Image(systemName: "list.dash")
                Text("Animals")
            }
        
            NavigationView {
                ShelterListView()
                    .navigationBarTitle("Shelters")
            }.tabItem {
                Image(systemName: "house")
                Text("Shelters")
            }
            
            NavigationView {
                SearchView()
                    .navigationBarTitle("Search")
            }.tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
            NavigationView {
                AnimalListView(arguments: FavoritesAnimalArguments(), customTitle: "Favorites")
                    .navigationBarTitle("Favorites")
            }.tabItem {
                Image(systemName: "heart")
                Text("Favorites")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
