//
//  ContentView.swift
//  Adoptable
//
//  Created by Rowan Hall on 7/18/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import SwiftUI

struct AnimalListView: View {
    
    @ObservedObject private var viewModel = AnimalListViewModel()
    var arguments: AnimalArguments
    var customTitle: String = ""
    
    var body: some View {
        ZStack {
            if (viewModel.resource.isIdle()) {
                Color.clear.onAppear(perform: { viewModel.getAnimalList(arguments: self.arguments) })
            } else {
                if (viewModel.resource.isLoading()) {
                    ProgressView()
                }
                if (viewModel.resource.hasError()) {
                    Text(viewModel.resource.error)
                }
                if (viewModel.resource.hasData()) {
                    if (viewModel.resource.resourceData!.isEmpty) {
                        Text("No animals found")
                    } else {
                        List {
                            ForEach(viewModel.resource.resourceData!) {animal in
                                AnimalItemView(animal: animal)
                                    .onAppear(perform: {
                                        if (self.viewModel.shouldPaginate(animal: animal)) {
                                            self.viewModel.getAnimalList(arguments: self.arguments)
                                        }
                                    }).background(NavigationLink("", destination: AnimalDetailView(animal: animal)).opacity(0))
                                    .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                }
            }
        }
        .primaryNavigationColor
        .navigationTitle(customTitle)
    }
}


