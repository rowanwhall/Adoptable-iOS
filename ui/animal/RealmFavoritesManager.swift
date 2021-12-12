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
    
    static let instance = RealmFavoritesManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    func isFavorite(id: String?) -> Bool {
        if (id == nil) {
            return false
        }
        let predicate = NSPredicate(format: "id = %@", id!)
        return realm.objects(AnimalRealmObject.self).filter(predicate).count > 0
    }
    
    func addToFavorites(animal: AnimalListItem) {
        try! realm.write() {
            realm.add(toRealmObject(animal: animal))
        }
    }
    
    func removeFromFavorites(animal: AnimalListItem) {
        try! realm.write {
            let predicate = NSPredicate(format: "id = %@", animal.id)
            realm.objects(AnimalRealmObject.self).filter(predicate).forEach { result in
                realm.delete(result)
            }
        }
    }
    
    func getFavorites() -> Results<AnimalRealmObject> {
        return realm.objects(AnimalRealmObject.self)
    }
    
    func toListItems(results: Results<AnimalRealmObject>) -> [AnimalListItem] {
        var animals: [AnimalListItem] = []
        for result in results {
            animals.append(toListItem(animal: result))
        }
        return animals
    }
    
    private func toListItem(animal: AnimalRealmObject) -> AnimalListItem {
        return AnimalListItem(
            id: animal.id,
            name: animal.name,
            type: animal.type,
            breed: animal.breed,
            size: animal.size,
            age: animal.age,
            sex: animal.sex,
            address1: animal.address1,
            address2: animal.address2,
            city: animal.city,
            state: animal.state,
            spayNeuter: animal.spayNeuter,
            houseTrained: animal.houseTrained,
            specialNeeds: animal.specialNeeds,
            shotsCurrent: animal.shotsCurrent,
            description: animal.descriptionString,
            email: animal.email,
            phone: animal.phone,
            goodWithChildren: animal.goodWithChildren,
            goodWithDogs: animal.goodWithDogs,
            goodWithCats: animal.goodWithCats,
            mainPhotoUrl: animal.mainPhotoUrl,
            photoUrls: animal.photoUrls.map { $0 },
            fetchPage: -1)
    }
    
    private func toRealmObject(animal: AnimalListItem) -> AnimalRealmObject {
        let realmObject = AnimalRealmObject()
        realmObject.id = animal.id
        realmObject.name = animal.name
        realmObject.type = animal.type
        realmObject.breed = animal.breed
        realmObject.size = animal.size
        realmObject.age = animal.age
        realmObject.sex = animal.sex
        realmObject.address1 = animal.address1
        realmObject.address2 = animal.address2
        realmObject.city = animal.city
        realmObject.state = animal.state
        realmObject.spayNeuter = animal.spayNeuter
        realmObject.houseTrained = animal.houseTrained
        realmObject.specialNeeds = animal.specialNeeds
        realmObject.shotsCurrent = animal.shotsCurrent
        realmObject.descriptionString = animal.description
        realmObject.email = animal.email
        realmObject.phone = animal.phone
        realmObject.goodWithChildren = animal.goodWithChildren
        realmObject.goodWithDogs = animal.goodWithDogs
        realmObject.goodWithCats = animal.goodWithCats
        realmObject.mainPhotoUrl = animal.mainPhotoUrl
        let photoUrls = List<String>()
        for photoUrl in animal.photoUrls {
            photoUrls.append(photoUrl)
        }
        realmObject.photoUrls = photoUrls
        return realmObject
    }
}
