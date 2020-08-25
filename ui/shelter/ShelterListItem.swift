//
//  ShelterListItem.swift
//  Adoptable
//
//  Created by Rowan Hall on 8/30/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import Foundation

struct ShelterListItem: Codable, Identifiable {
    var id: String
    var name: String
    var contact: String
    var location: String
    var fetchPage: Int
    
    func title() -> String {
        return location
    }
    
    func subtitle() -> String {
        return contact
    }
}
