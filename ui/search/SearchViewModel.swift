//
//  SearchViewModel.swift
//  Adoptable
//
//  Created by Rowan Hall on 2/26/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation
import Combine

class SearchViewModel : ObservableObject {
    
    static let DEFAULT_BREED_SELECTION = BreedListItem(id: UUID(), name: "Any Breed")
    
    var subscriptions: Set<AnyCancellable> = []
    @Published var resource: Resource<[BreedListItem]> = Resource<[BreedListItem]>.initialize()
    
    func getBreeds(type: String?) {
        if type == nil {
            self.resource = Resource.success(resourceData: [SearchViewModel.DEFAULT_BREED_SELECTION])
            return
        }
        
        petfinderRepository.getBreeds(type: type!)
            .map { (response: BreedsResponse?) -> Resource<[BreedListItem]> in
                var results = [SearchViewModel.DEFAULT_BREED_SELECTION]
                results += response!.toBreedArray()
                return Resource.success(resourceData: results)
            }
            .prepend(Resource.progress(resource: self.resource))
            .replaceError(with: Resource.failure(resource: self.resource, error: "An error occurred"))
            .receive(on: RunLoop.main)
            .sink { resource in self.resource = resource }
            .store(in: &subscriptions)
    }
    
    func getBreedParamForIndex(index: Int) -> String? {
        if index <= 0 || !resource.hasData() || resource.resourceData?.count ?? 0 < index {
            return nil
        }
        return resource.resourceData![index].name
    }
}
