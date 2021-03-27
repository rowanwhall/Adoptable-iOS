//
//  AnimalRealmObject.swift
//  Adoptable
//
//  Created by Rowan Hall on 3/20/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation
import RealmSwift

class AnimalRealmObject: Object {
    @objc var id: String = ""
    @objc var name: String = ""
    @objc var type: String = ""
    @objc var breed: String = ""
    @objc var size: String = ""
    @objc var age: String = ""
    @objc var sex: String = ""
    @objc var city: String? = ""
    @objc var state: String? = ""
    @objc var spayNeuter: Bool = false
    @objc var houseTrained: Bool = false
    @objc var specialNeeds: Bool = false
    @objc var shotsCurrent: Bool = false
    @objc var descriptionString: String = ""
    @objc var mainPhotoUrl: String? = ""
    
    static func toRealmObject(animal: AnimalListItem) -> AnimalRealmObject {
        let realmObject = AnimalRealmObject()
        realmObject.id = animal.id
        realmObject.name = animal.name
        realmObject.type = animal.type
        realmObject.breed = animal.breed
        realmObject.size = animal.size
        realmObject.age = animal.age
        realmObject.sex = animal.sex
        realmObject.city = animal.city
        realmObject.state = animal.state
        realmObject.spayNeuter = animal.spayNeuter
        realmObject.houseTrained = animal.houseTrained
        realmObject.specialNeeds = animal.specialNeeds
        realmObject.shotsCurrent = animal.shotsCurrent
        realmObject.descriptionString = animal.description
        realmObject.mainPhotoUrl = animal.mainPhotoUrl
        return realmObject
    }
    
    static func toListItem(animal: AnimalRealmObject) -> AnimalListItem {
        return AnimalListItem(
            id: animal.id,
            name: animal.name,
            type: animal.type,
            breed: animal.breed,
            size: animal.size,
            age: animal.age,
            sex: animal.sex,
            city: animal.city,
            state: animal.state,
            spayNeuter: animal.spayNeuter,
            houseTrained: animal.houseTrained,
            specialNeeds: animal.specialNeeds,
            shotsCurrent: animal.shotsCurrent,
            description: animal.descriptionString,
            mainPhotoUrl: animal.mainPhotoUrl,
            fetchPage: -1)
    }
}
