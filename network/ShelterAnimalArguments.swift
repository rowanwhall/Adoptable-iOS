//
//  ShelterAnimalArguments.swift
//  Adoptable
//
//  Created by Rowan Hall on 1/10/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation

struct ShelterAnimalArguments : AnimalArguments {
    
    func type() -> AnimalArgumentType {
        return AnimalArgumentType.shelter
    }
    
    var shelterId: String
}
