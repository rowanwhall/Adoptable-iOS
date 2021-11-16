//
//  AnimalDetailViewModel.swift
//  Adoptable
//
//  Created by Rowan Hall on 3/26/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation

class AnimalDetailViewModel: ObservableObject {
    
    @Published var favoriteButtonLabel = ""
    @Published var favoriteButtonIcon = ""
    
    func initializeFavoriteButton(animal: AnimalListItem) {
        if (RealmFavoritesManager.instance.isFavorite(id: animal.id)) {
            favoriteButtonLabel = "Remove from Favorites"
            favoriteButtonIcon = "heart.fill"
        } else {
            favoriteButtonLabel = "Add to Favorites"
            favoriteButtonIcon = "heart"
        }
    }
    
    func addOrRemoveFromFavorites(animal: AnimalListItem) {
        let realmManager = RealmFavoritesManager.instance
        if (realmManager.isFavorite(id: animal.id)) {
            realmManager.removeFromFavorites(animal: animal)
            favoriteButtonLabel = "Add to Favorites"
            favoriteButtonIcon = "heart"
        } else {
            realmManager.addToFavorites(animal: animal)
            favoriteButtonLabel = "Remove from Favorites"
            favoriteButtonIcon = "heart.fill"
        }
    }
    
}
