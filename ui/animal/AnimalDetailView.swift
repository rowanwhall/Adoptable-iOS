//
//  AnimalDetailView.swift
//  Adoptable
//
//  Created by Rowan Hall on 10/18/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import SwiftUI

struct AnimalDetailView: View {
    
    @ObservedObject private var viewModel = AnimalDetailViewModel()
    var animal: AnimalListItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if (animal.mainPhotoUrl != nil && !animal.mainPhotoUrl!.isEmpty) {
                    AsyncImage(
                        url: URL(string: animal.mainPhotoUrl!)!,
                        placeholder: { Text("Loading Image") },
                        image: { Image(uiImage: $0).resizable() }
                    ).frame(idealHeight: UIScreen.main.bounds.width / 4 * 3)
                }
                
                Spacer()
                
                Text(animal.header())
                    .font(.headline)
                Text(animal.detail())
                    .font(.subheadline)
                if (!animal.description.isEmpty) {
                    Spacer()
                    Text(animal.description)
                }
                
                Spacer()
                
                Button(viewModel.favoriteButtonLabel, action: { viewModel.addOrRemoveFromFavorites(animal: animal) })
                    .onAppear(perform: { viewModel.initializeFavoriteButton(animal: animal) })
            }.navigationBarTitle(animal.name)
        }.padding()
    }
}
