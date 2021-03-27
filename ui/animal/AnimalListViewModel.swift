//
//  AnimalListViewModel.swift
//  Adoptable
//
//  Created by Rowan Hall on 8/25/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import Foundation
import Combine
import RealmSwift

class AnimalListViewModel: ObservableObject {
    
    var subscriptions: Set<AnyCancellable> = []
    var realmToken: NotificationToken? = nil
    @Published var resource: Resource<[AnimalListItem]> = Resource<[AnimalListItem]>.initialize()
    var nextPage = 1
    
    private var isFavorites = false
    
    func getAnimalList(arguments: AnimalArguments) {
        if (arguments.type() == AnimalArgumentType.favorites) {
            self.isFavorites = true
            let realmManager = RealmFavoritesManager.instance
            let realmResults = realmManager.getFavorites()
            realmToken = realmResults.observe { change in
                switch change {
                case .initial:
                        self.resource = Resource.success(resourceData: realmManager.toListItems(results: realmResults))
                    case .update(_, _, _, _):
                        self.realmToken?.invalidate()
                        self.getAnimalList(arguments: arguments)
                    case .error(_):
                        self.resource = Resource.failure(resource: self.resource, error: "An error occurred")
                }
                
            }
            return
        }
        
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
        if (isFavorites) {
            return false
        }
        return animal.fetchPage >= nextPage
    }
}
