//
//  PetfinderRepository.swift
//  Adoptable
//
//  Created by Rowan Hall on 8/25/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import Foundation
import Combine

let petfinderRepository = PetfinderRepository()

class PetfinderRepository {
    
    private let BASE_URL = "https://api.petfinder.com/v2/"
    private var oAuthToken: String? = nil
    
    private func combineAuthToken() -> AnyPublisher<String?, Never> {
        if self.oAuthToken != nil {
            return Just(self.oAuthToken).eraseToAnyPublisher()
        }
        
        let oAuthJsonDict: [String: Any] = [
            "grant_type": "client_credentials",
            "client_id": Constants.CLIENT_ID,
            "client_secret": Constants.CLIENT_SECRET
        ]
        let oAuthJsonData = try? JSONSerialization.data(withJSONObject: oAuthJsonDict)
        var oAuthRequest = URLRequest(url: URL(string: BASE_URL + "oauth2/token")!)
        oAuthRequest.httpMethod = "POST"
        oAuthRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        oAuthRequest.httpBody = oAuthJsonData
        
        return URLSession.shared.dataTaskPublisher(for: oAuthRequest)
            .tryMap { (data, response) -> String? in
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                    self.oAuthToken = responseJSON["access_token"] as? String
                }
                return self.oAuthToken
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
    private func combineAnimalList(arguments: AnimalArguments, page: Int, token: String) -> AnyPublisher<AnimalResponse?, Error> {
        var url = URLComponents(string: BASE_URL + "animals")!
        url.queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        switch arguments.type() {
        case AnimalArgumentType.find:
            let nearbyArguments = arguments as! NearbyAnimalArguments
            url.queryItems?.append(URLQueryItem(name: "location", value: nearbyArguments.location))
            if nearbyArguments.animal != nil {
                url.queryItems?.append(URLQueryItem(name: "type", value: nearbyArguments.animal))
            }
            if nearbyArguments.size != nil {
                url.queryItems?.append(URLQueryItem(name: "size", value: nearbyArguments.size))
            }
            if nearbyArguments.age != nil {
                url.queryItems?.append(URLQueryItem(name: "age", value: nearbyArguments.age))
            }
            if nearbyArguments.sex != nil {
                url.queryItems?.append(URLQueryItem(name: "gender", value: nearbyArguments.sex))
            }
            if nearbyArguments.breed != nil {
                url.queryItems?.append(URLQueryItem(name: "breed", value: nearbyArguments.breed))
            }
        case AnimalArgumentType.shelter:
            let shelterArguments = arguments as! ShelterAnimalArguments
            url.queryItems?.append(URLQueryItem(name: "organization", value: shelterArguments.shelterId))
        case AnimalArgumentType.favorites:
            print("ERROR: Favorites type should never reach Combine function")
        }
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        let headerDict: [String: String] = [
            "AUTHORIZATION": "Bearer " + token
        ]
        request.allHTTPHeaderFields = headerDict
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> AnimalResponse? in
                return try? JSONDecoder().decode(AnimalResponse.self, from: data)
            }
            .eraseToAnyPublisher()
    }
    
    func getAnimalList(arguments: AnimalArguments, page: Int) -> AnyPublisher<AnimalResponse?, Error> {
        return combineAuthToken().flatMap { token in
            return self.combineAnimalList(arguments: arguments, page: page, token: token!)
        }
        .eraseToAnyPublisher()
    }
    
    private func combineShelterList(page: Int, token: String) -> AnyPublisher<ShelterResponse?, Error> {
        var url = URLComponents(string: BASE_URL + "organizations")!
        url.queryItems = [
            URLQueryItem(name: "location", value: "30308"),
            URLQueryItem(name: "page", value: String(page))
        ]
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        let headerDict: [String: String] = [
            "AUTHORIZATION": "Bearer " + token
        ]
        request.allHTTPHeaderFields = headerDict
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> ShelterResponse? in
                return try? JSONDecoder().decode(ShelterResponse.self, from: data)
            }
            .eraseToAnyPublisher()
    }
    
    func getShelterList(page: Int) -> AnyPublisher<ShelterResponse?, Error> {
        return combineAuthToken().flatMap { token in
            return self.combineShelterList(page: page, token: token!)
        }
        .eraseToAnyPublisher()
    }
    
    private func combineBreedSearch(type: String, token: String) -> AnyPublisher<BreedsResponse?, Error> {
        let url = URLComponents(string: BASE_URL + "types/" + type + "/breeds")!
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        let headerDict: [String: String] = [
            "AUTHORIZATION": "Bearer " + token
        ]
        request.allHTTPHeaderFields = headerDict
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> BreedsResponse? in
                return try? JSONDecoder().decode(BreedsResponse.self, from: data)
            }
            .eraseToAnyPublisher()
    }
    
    func getBreeds(type: String) -> AnyPublisher<BreedsResponse?, Never> {
        return combineAuthToken().flatMap { token in
            return self.combineBreedSearch(type: type, token: token!)
        }
        .replaceError(with: nil)
        .eraseToAnyPublisher()
    }
}
