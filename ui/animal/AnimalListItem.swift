//
//  Animal.swift
//  Adoptable
//
//  Created by Rowan Hall on 7/19/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import Foundation

struct AnimalListItem: Codable, Identifiable {
    var id: String
    var name: String
    var type: String
    var breed: String
    var size: String
    var age: String
    var sex: String
    var address1: String
    var address2: String
    var city: String?
    var state: String?
    var spayNeuter: Bool
    var houseTrained: Bool
    var specialNeeds: Bool
    var shotsCurrent: Bool
    var description: String
    var email: String?
    var phone: String?
    var goodWithChildren: Bool
    var goodWithDogs: Bool
    var goodWithCats: Bool
    var mainPhotoUrl: String?
    var photoUrls: [String]
    var fetchPage: Int
    
    func header() -> String {
        return type + " - " + breed
    }
    
    func detail() -> String {
        return size + " - " + age + " - " + sex + " - " + location() + attributes()
    }
    
    func showEnvironment() -> Bool {
        return goodWithCats || goodWithDogs || goodWithChildren
    }
    
    func environment() -> String {
        var environment = ""
        if (goodWithChildren) {
            environment.append("children")
        }
        if (goodWithDogs) {
            if (!environment.isEmpty) {
                environment.append(", ")
            }
            environment.append("dogs")
        }
        if (goodWithCats) {
            if (!environment.isEmpty) {
                environment.append(", ")
            }
            environment.append("cats")
        }
        
        return "Good with: " + environment
    }
    
    func showAddress() -> Bool {
        return !address1.isEmpty || !address2.isEmpty
    }
    
    func address() -> String {
        var address = ""
        if (!address1.isEmpty) {
            address.append(address1)
        }
        if (!address2.isEmpty) {
            if (!address.isEmpty) {
                address.append("\n")
            }
            address.append(address2)
        }
        address.append("\n")
        address.append(location())
        return address
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
