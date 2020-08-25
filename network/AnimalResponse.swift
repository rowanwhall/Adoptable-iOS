//
//  AnimalResponse.swift
//  Adoptable
//
//  Created by Rowan Hall on 7/19/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import Foundation

struct AnimalResponse: Codable {
    var animals: [AnimalResponseItem]
    var pagination: PaginationResponseItem
    
    func toAnimals() -> [AnimalListItem] {
        var animalArray: [AnimalListItem] = []
        let isLastPage = pagination.current_page >= pagination.total_pages
        var i = 0
        for responseItem in animals {
            i += 1
            animalArray.append(AnimalListItem(
                id: responseItem.id,
                name: responseItem.name,
                type: responseItem.type ?? "Type not available",
                breed: responseItem.breeds.primary ?? "Breed not available",
                size: responseItem.size ?? "Size not available",
                age: responseItem.age ?? "Age not available",
                sex: responseItem.gender ?? "Gender not available",
                city: responseItem.contact.address.city,
                state: responseItem.contact.address.state,
                spayNeuter: responseItem.attributes.spayed_neutered,
                houseTrained: responseItem.attributes.house_trained,
                specialNeeds: responseItem.attributes.special_needs,
                shotsCurrent: responseItem.attributes.shots_current,
                description: responseItem.description ?? "",
                mainPhotoUrl: mainPhotoUrl(photos: responseItem.photos),
                fetchPage: !isLastPage && i == animals.count ? pagination.current_page + 1 : -1))
        }
        return animalArray
    }
    
    func currentPage() -> Int {
        return pagination.current_page
    }
    
    private func mainPhotoUrl(photos: [PhotoResponseItem]) -> String? {
        if (!photos.isEmpty) {
            for photo in photos {
                if (photo.full != nil) {
                    return photo.full
                }
            }
            for photo in photos {
                if (photo.large != nil) {
                    return photo.large
                }
            }
            for photo in photos {
                if (photo.medium != nil) {
                    return photo.medium
                }
            }
            for photo in photos {
                if (photo.small != nil) {
                    return photo.small
                }
            }
        }
        
        return nil
    }
}

struct AnimalResponseItem: Codable {
    var id: Int
    //var organization_id: String
    var type: String?
    var species: String?
    var breeds: BreedResponseItem
    var colors: ColorResponseItem
    var age: String?
    var gender: String?
    var size: String?
    var coat: String?
    var attributes: AttributesResponseItem
    var environment: EnvironmentResponseItem
    var name: String
    var description: String?
    var photos: [PhotoResponseItem]
    var status: String
    var distance: Float?
    var contact: ContactResponseItem
}

struct BreedResponseItem: Codable {
    var primary: String?
    var secondary: String?
    var mixed: Bool
    var unknown: Bool
}

struct ColorResponseItem: Codable {
    var primary: String?
    var secondary: String?
    var tertiary: String?
}

struct AttributesResponseItem: Codable {
    var spayed_neutered: Bool
    var house_trained: Bool
    var declawed: Bool?
    var special_needs: Bool
    var shots_current: Bool
}

struct EnvironmentResponseItem: Codable {
    var children: Bool?
    var dogs: Bool?
    var cats: Bool?
}

struct PhotoResponseItem: Codable {
    var small: String?
    var medium: String?
    var large: String?
    var full: String?
}

struct ContactResponseItem: Codable {
    var email: String?
    var phone: String?
    var address: AddressResponseItem
}

struct AddressResponseItem: Codable {
    var address1: String?
    var address2: String?
    var city: String?
    var state: String?
    var postcode: String?
    var country: String?
}

struct PaginationResponseItem: Codable {
    var count_per_page: Int
    var total_count: Int
    var current_page: Int
    var total_pages: Int
}
