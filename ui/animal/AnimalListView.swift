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
    var customTitle: String = "Animals"
    
    var body: some View {
        ZStack {
            if (viewModel.resource.isIdle()) {
                Color.clear.onAppear(perform: { viewModel.getAnimalList(arguments: self.arguments) })
            } else {
                if (viewModel.resource.isLoading()) {
                    Text("Loading")
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
                                NavigationLink(destination: AnimalDetailView(animal: animal)) {
                                    AnimalCard(animal: animal)
                                        .onAppear(perform: {
                                            if (self.viewModel.shouldPaginate(animal: animal)) {
                                                self.viewModel.getAnimalList(arguments: self.arguments)
                                            }
                                    })
                                }
                            }
                        }
                    }
                }
            }
        }
        .blueNavigation
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
                    placeholder: { Text("Loading Image") },
                    image: { Image(uiImage: $0).resizable() }
                ).frame(idealHeight: UIScreen.main.bounds.width / 4 * 3)
            }
            
            Text(animal.name)
                .font(.largeTitle)
            Spacer()
            Text(animal.header())
                .font(.headline)
            Text(animal.detail())
                .font(.subheadline)
        }.padding()
    }
}
