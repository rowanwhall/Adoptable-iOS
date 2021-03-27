//
//  FavoritesAnimalArguments.swift
//  Adoptable
//
//  Created by Rowan Hall on 3/26/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation

struct FavoritesAnimalArguments : AnimalArguments {
    
    func type() -> AnimalArgumentType {
        return AnimalArgumentType.favorites
    }
}
