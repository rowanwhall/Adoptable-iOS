//
//  NearbyAnimalArguments.swift
//  Adoptable
//
//  Created by Rowan Hall on 1/10/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation

struct NearbyAnimalArguments : AnimalArguments {
    
    func type() -> AnimalArgumentType {
        return AnimalArgumentType.find
    }
    
    var location: String
    var animal: String?
    var size: String?
    var age: String?
    var sex: String?
    var breed: String?
}
