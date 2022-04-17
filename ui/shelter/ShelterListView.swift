//
//  ShelterListView.swift
//  Adoptable
//
//  Created by Rowan Hall on 9/6/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import SwiftUI

struct ShelterListView: View {
    
    @ObservedObject private var viewModel = ShelterListViewModel()
    
    var body: some View {
        ZStack {
            if (viewModel.resource.isIdle()) {
                Color.clear.onAppear(perform: { viewModel.getShelterList() })
            } else {
                if (viewModel.resource.isLoading()) {
                    ProgressView()
                }
                if (viewModel.resource.hasError()) {
                    Text(viewModel.resource.error)
                }
                if (viewModel.resource.hasData()) {
                    if (viewModel.resource.resourceData!.isEmpty) {
                        Text("No shelters found")
                    } else {
                        List {
                            ForEach(viewModel.resource.resourceData!) {shelter in
                                NavigationLink(destination:
                                                AnimalListView(arguments:ShelterAnimalArguments(shelterId: shelter.id), customTitle: shelter.name)) {
                                    ShelterItemView(shelter: shelter)
                                        .onAppear(perform: {
                                            if (self.viewModel.shouldPaginate(shelter: shelter)) {
                                                self.viewModel.getShelterList()
                                            }
                                    })
                                }
                            }
                        }.refreshable {
                            viewModel.getShelterList(clear: true)
                        }
                    }
                }
            }
        }
        .primaryNavigationColor
    }
}

struct ShelterItemView: View {
    var shelter: ShelterListItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(shelter.name)
                .font(.largeTitle)
            Text(shelter.title())
                .font(.headline)
            Text(shelter.subtitle())
                .font(.subheadline)
        }.padding()
    }
}
