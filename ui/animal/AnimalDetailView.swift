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
                AnimalCard(animal: animal)
                
                if (animal.showEnvironment()) {
                    Divider()
                    Text(animal.environment())
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .font(.subheadline)
                }
                
                if (!animal.description.isEmpty) {
                    Divider()
                    Text(animal.description)
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .font(.subheadline)
                }
                
            
                if (animal.phone != nil) {
                    Divider()
                    Text(animal.phone!)
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .font(.subheadline)
                }
                
                if (animal.email != nil) {
                    Divider()
                    Button(animal.email!, action: {
                        if let emailUrl = URL(string: "mailto:\(animal.email!)") {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(emailUrl)
                            } else {
                                UIApplication.shared.openURL(emailUrl)
                            }
                        }
                    })
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .font(.subheadline)
                }
                
                if (animal.showAddress()) {
                    Divider()
                    Button(animal.address(), action: {
                        if let encodedAddress = animal.address1.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                            if let addressUrl = URL(string: "http://maps.apple.com/?address=\(encodedAddress)") {
                                print(addressUrl.absoluteString)
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(addressUrl)
                                } else {
                                    UIApplication.shared.openURL(addressUrl)
                                }
                            }
                        }
                    })
                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .font(.subheadline)
                        .frame(alignment: .leading)
                }
                
                Button(viewModel.favoriteButtonLabel, action: { viewModel.addOrRemoveFromFavorites(animal: animal) })
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 4, trailing: 16))
                    .frame(maxWidth: .infinity)
                    .onAppear(perform: { viewModel.initializeFavoriteButton(animal: animal) })
            }.navigationBarTitle(animal.name)
        }.primaryNavigationColor
    }
}
