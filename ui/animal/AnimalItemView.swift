//
//  AnimalItemView.swift
//  Adoptable
//
//  Created by Rowan Hall on 11/16/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import SwiftUI

struct AnimalItemView: View {
    var animal: AnimalListItem
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if (animal.mainPhotoUrl != nil && !animal.mainPhotoUrl!.isEmpty) {
                AsyncImage(
                    url: URL(string: animal.mainPhotoUrl!)!,
                    placeholder: { ProgressView().frame(maxWidth: .infinity) },
                    image: { Image(uiImage: $0) }
                )
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
