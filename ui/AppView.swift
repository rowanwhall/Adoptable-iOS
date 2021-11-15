//
//  AppView.swift
//  Adoptable
//
//  Created by Rowan Hall on 8/30/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
    var location: String = ""
    
    var body: some View {
        TabView {
            NavigationView {
                AnimalListView(arguments: NearbyAnimalArguments(location: self.location, animal: nil, size: nil, age: nil, sex: nil, breed: nil))
                    .navigationBarTitle("Animals")
            }.tabItem {
                Image(systemName: "list.dash")
                Text("Animals")
            }
            .edgesIgnoringSafeArea([.top, .bottom])
        
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
        .accentColor(Color.primaryColorLegacy)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}
