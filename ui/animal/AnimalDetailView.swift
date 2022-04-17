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
                AnimalItemView(animal: animal)
                
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
                    ButtonRowView(text: animal.phone!, imageName: "phone") {
                        let filteredPhone = animal.phone!.filter("0123456789".contains)
                        if let phoneUrl = URL(string: "tel:\(filteredPhone)") {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(phoneUrl)
                            } else {
                                UIApplication.shared.openURL(phoneUrl)
                            }
                        }
                    }
                }
                
                if (animal.email != nil) {
                    Divider()
                    ButtonRowView(text: animal.email!, imageName: "envelope") {
                        if let emailUrl = URL(string: "mailto:\(animal.email!)") {
                            if #available(iOS 10.0, *) {
                                UIApplication.shared.open(emailUrl)
                            } else {
                                UIApplication.shared.openURL(emailUrl)
                            }
                        }
                    }
                }
                
                if (animal.showAddress()) {
                    Divider()
                    ButtonRowView(text: animal.address(), imageName: "location") {
                        if let encodedAddress = animal.address1.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                            if let addressUrl = URL(string: "http://maps.apple.com/?address=\(encodedAddress)") {
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(addressUrl)
                                } else {
                                    UIApplication.shared.openURL(addressUrl)
                                }
                            }
                        }
                    }
                }
                
                Divider()
                ButtonRowView(text: viewModel.favoriteButtonLabel, imageName: viewModel.favoriteButtonIcon) {
                    viewModel.addOrRemoveFromFavorites(animal: animal)
                }.onAppear(perform: { viewModel.initializeFavoriteButton(animal: animal) })
                
                Spacer()
            }.navigationBarTitle(animal.name)
                .toolbar {
                    if (animal.photoUrls.count > 1) {
                        NavigationLink("All Photos", destination: AnimalGalleryView(photoUrls: animal.photoUrls))
                            .foregroundColor(Color.white)
                    }
                }
        }.primaryNavigationColor
    }
}

struct ButtonRowView: View {
    
    var text: String
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(Color.primaryColorLegacy)
            
            Button(text, action: { action() })
                .font(.subheadline)
                .foregroundColor(Color.primaryColorLegacy)
        }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}
