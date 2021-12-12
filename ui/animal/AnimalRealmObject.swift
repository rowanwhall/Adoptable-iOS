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
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var breed: String = ""
    @objc dynamic var size: String = ""
    @objc dynamic var age: String = ""
    @objc dynamic var sex: String = ""
    @objc dynamic var address1: String = ""
    @objc dynamic var address2: String = ""
    @objc dynamic var city: String? = ""
    @objc dynamic var state: String? = ""
    @objc dynamic var spayNeuter: Bool = false
    @objc dynamic var houseTrained: Bool = false
    @objc dynamic var specialNeeds: Bool = false
    @objc dynamic var shotsCurrent: Bool = false
    @objc dynamic var descriptionString: String = ""
    @objc dynamic var email: String? = ""
    @objc dynamic var phone: String? = ""
    @objc dynamic var goodWithChildren: Bool = false
    @objc dynamic var goodWithDogs: Bool = false
    @objc dynamic var goodWithCats: Bool = false
    @objc dynamic var mainPhotoUrl: String? = ""
    var photoUrls: List<String> = List<String>()
}
