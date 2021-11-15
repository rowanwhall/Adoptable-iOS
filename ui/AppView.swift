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
            AnimalListView(arguments: NearbyAnimalArguments(location: self.location, animal: nil, size: nil, age: nil, sex: nil, breed: nil))
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Animals")
                }
        
            ShelterListView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Shelters")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            AnimalListView(arguments: FavoritesAnimalArguments(), customTitle: "Favorites")
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
        }
        .accentColor(Color.primaryColorLegacy)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("toolbarImageSet")
            }
        }
    }
}
