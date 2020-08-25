//
//  AnimalArguments.swift
//  Adoptable
//
//  Created by Rowan Hall on 1/10/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation

protocol AnimalArguments {
    func type() -> AnimalArgumentType
}

enum AnimalArgumentType {
    case find, shelter
}
