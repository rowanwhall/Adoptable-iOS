//
//  ShelterViewModel.swift
//  Adoptable
//
//  Created by Rowan Hall on 9/6/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import Foundation
import Combine

class ShelterListViewModel: ObservableObject {
    
    var subscriptions: Set<AnyCancellable> = []
    @Published var resource: Resource<[ShelterListItem]> = Resource<[ShelterListItem]>.initialize()
    var nextPage = 1
    
    func getShelterList() {
        petfinderRepository.getShelterList(page: nextPage)
            .map { (response: ShelterResponse?) -> Resource<[ShelterListItem]> in
                var results = self.resource.resourceData ?? []
                results += response!.toShelters()
                self.nextPage = response!.currentPage() + 1
                return Resource.success(resourceData: results)
            }
            .prepend(Resource.progress(resource: self.resource))
            .replaceError(with: Resource.failure(resource: self.resource, error: "An error occurred"))
            .receive(on: RunLoop.main)
            .sink { resource in self.resource = resource }
            .store(in: &subscriptions)
    }
    
    func shouldPaginate(shelter: ShelterListItem) -> Bool {
        return shelter.fetchPage >= nextPage
    }
}
