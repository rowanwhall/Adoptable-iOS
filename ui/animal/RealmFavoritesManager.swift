//
//  RealmFavoritesManager.swift
//  Adoptable
//
//  Created by Rowan Hall on 3/26/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation
import RealmSwift

class RealmFavoritesManager {
    
    let realm = try! Realm()
    
    func isFavorite(id: String?) -> Bool {
        if (id == nil) {
            return false
        }
        let predicate = NSPredicate(format: "id = %@", id!)
        return realm.objects(AnimalRealmObject.self).filter(predicate).count > 0
    }
    
    func addToFavorites(animal: AnimalListItem) {
        try! realm.write() {
            realm.add(AnimalRealmObject.toRealmObject(animal: animal))
        }
    }
    
    func getFavorites() -> [AnimalListItem] {
        let results = realm.objects(AnimalRealmObject.self)
        var animals: [AnimalListItem] = []
        for result in results {
            animals.append(AnimalRealmObject.toListItem(animal: result))
        }
        return animals
    }
}
