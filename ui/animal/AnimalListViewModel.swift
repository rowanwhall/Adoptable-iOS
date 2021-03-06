//
//  AnimalListViewModel.swift
//  Adoptable
//
//  Created by Rowan Hall on 8/25/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import Foundation
import Combine

class AnimalListViewModel: ObservableObject {
    
    var subscriptions: Set<AnyCancellable> = []
    @Published var resource: Resource<[AnimalListItem]> = Resource<[AnimalListItem]>.initialize()
    var nextPage = 1
    
    func getAnimalList(arguments: AnimalArguments) {
        petfinderRepository.getAnimalList(arguments: arguments, page: nextPage)
            .map { (response: AnimalResponse?) -> Resource<[AnimalListItem]> in
                var results = self.resource.resourceData ?? []
                results += response!.toAnimals()
                self.nextPage = response!.currentPage() + 1
                return Resource.success(resourceData: results)
            }
            .prepend(Resource.progress(resource: self.resource))
            .replaceError(with: Resource.failure(resource: self.resource, error: "An error occurred"))
            .receive(on: RunLoop.main)
            .sink { resource in self.resource = resource }
            .store(in: &subscriptions)
    }
    
    func shouldPaginate(animal: AnimalListItem) -> Bool {
        return animal.fetchPage >= nextPage
    }
}
