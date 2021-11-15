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
        Group {
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
                                AnimalCard(animal: animal)
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

struct AnimalCard: View {
    var animal: AnimalListItem
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if (animal.mainPhotoUrl != nil && !animal.mainPhotoUrl!.isEmpty) {
                AsyncImage(
                    url: URL(string: animal.mainPhotoUrl!)!,
                    placeholder: { ProgressView() },
                    image: { Image(uiImage: $0).resizable() }
                ).frame(idealHeight: UIScreen.main.bounds.width / 4 * 3)
            }
            
            Text(animal.name)
                .font(.largeTitle)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 4, trailing: 16))
            Text(animal.header())
                .font(.headline)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16))
            Text(animal.detail())
                .font(.subheadline)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        }
    }
}
