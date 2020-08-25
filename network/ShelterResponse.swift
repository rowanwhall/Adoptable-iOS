//
//  ShelterResponse.swift
//  Adoptable
//
//  Created by Rowan Hall on 8/30/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import Foundation

struct ShelterResponse: Codable {
    var organizations: [ShelterResponseItem]
    var pagination: PaginationResponseItem
    
    func toShelters() -> [ShelterListItem] {
        var shelterArray: [ShelterListItem] = []
        let isLastPage = pagination.current_page >= pagination.total_pages
        var i = 0
        for responseItem in organizations {
            i += 1
            let contact = responseItem.phone ?? responseItem.email ?? "Contact not available"
            shelterArray.append(ShelterListItem(
                id: responseItem.id,
                name: responseItem.name,
                contact: contact,
                location: responseItem.address.city ?? "Location not available",
                fetchPage: !isLastPage && i == organizations.count ? pagination.current_page + 1 : -1))
        }
        return shelterArray
    }
    
    func currentPage() -> Int {
        return pagination.current_page
    }
}

struct ShelterResponseItem: Codable {
    var id: String
    var name: String
    var email: String?
    var phone: String?
    var address: AddressResponseItem
    var hours: HoursResponseItem
    var url: String?
    var website: String?
    var mission_statement: String?
    var adoption: AdoptionResponseItem
    var social_media: SocialMediaResponseItem
    var photos: [PhotoResponseItem]
    var distance: Float?
}

struct HoursResponseItem: Codable {
    var monday: String?
    var tuesday: String?
    var wednesday: String?
    var thursday: String?
    var friday: String?
    var saturday: String?
    var sunday: String?
}

struct AdoptionResponseItem: Codable {
    var policy: String?
    var url: String?
}

struct SocialMediaResponseItem: Codable {
    var facebook: String?
    var twitter: String?
    var youtube: String?
    var instagram: String?
    var pinterest: String?
}
