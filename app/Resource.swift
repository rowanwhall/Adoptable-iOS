//
//  Resource.swift
//  Adoptable
//
//  Created by Rowan Hall on 2/15/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation

struct Resource<T> {

    var progress = false
    var resourceData: T? = nil
    var error = ""
    
    private init(progress: Bool, resourceData: T?, error: String) {
        self.progress = progress
        self.resourceData = resourceData
        self.error = error
    }
    
    static func initialize<T>() -> Resource<T> {
        return Resource<T>(progress: false, resourceData: nil, error: "")
    }
    
    static func progress(resource: Resource<T>) -> Resource<T> {
        return Resource<T>(progress: true, resourceData: resource.resourceData, error: resource.error)
    }
    
    static func success(resourceData: T) -> Resource<T> {
        return Resource<T>(progress: false, resourceData: resourceData, error: "")
    }
    
    static func failure(resource: Resource<T>, error: String) -> Resource<T> {
        return Resource<T>(progress: false, resourceData: resource.resourceData, error: error)
    }
    
    func isIdle() -> Bool {
        return progress == false && error.isEmpty && resourceData == nil
    }
    
    func isLoading() -> Bool {
        return progress
    }
    
    func hasData() -> Bool {
        return resourceData != nil
    }
    
    func hasError() -> Bool {
        return !error.isEmpty
    }
}

