//
//  Animal.swift
//  Adoptable
//
//  Created by Rowan Hall on 7/19/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import Foundation

struct AnimalListItem: Codable, Identifiable {
    var id: Int
    var name: String
    var type: String
    var breed: String
    var size: String
    var age: String
    var sex: String
    var city: String?
    var state: String?
    var spayNeuter: Bool
    var houseTrained: Bool
    var specialNeeds: Bool
    var shotsCurrent: Bool
    var description: String
    var mainPhotoUrl: String?
    var fetchPage: Int
    
    func header() -> String {
        return type + " - " + breed
    }
    
    func detail() -> String {
        return size + " - " + age + " - " + sex + " - " + location() + attributes()
    }
    
    private func location() -> String {
        if (city != nil && state != nil) {
            return city! + ", " + state!
        } else if (state != nil) {
            return state!
        } else {
            return "Location not available"
        }
    }
    
    private func attributes() -> String {
        var attributes = ""
        if (spayNeuter) {
            attributes.append("Fixed")
        }
        if (houseTrained) {
            if (!attributes.isEmpty) {
                attributes.append(" - ")
            }
            attributes.append("House Trained")
        }
        if (specialNeeds) {
            if (!attributes.isEmpty) {
                attributes.append(" - ")
            }
            attributes.append("Special Needs")
        }
        if (shotsCurrent) {
            if (!attributes.isEmpty) {
                attributes.append(" - ")
            }
            attributes.append("Shots Current")
        }
        
        if (attributes.isEmpty) {
            return ""
        } else {
            return " - " + attributes
        }
    }
}
