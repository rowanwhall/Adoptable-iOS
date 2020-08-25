//
//  BreedsResponse.swift
//  Adoptable
//
//  Created by Rowan Hall on 2/26/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation

struct BreedsResponse: Codable {
    var breeds: [BreedSearchResponseItem]
    
    func toBreedArray() -> [BreedListItem] {
        var breedListItems: [BreedListItem] = []
        for breed in self.breeds {
            breedListItems.append(BreedListItem(id: UUID(), name: breed.name))
        }
        return breedListItems
    }
}

struct BreedSearchResponseItem: Codable {
    var name: String
}
