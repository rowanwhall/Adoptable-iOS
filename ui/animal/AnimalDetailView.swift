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
                    HStack {
                        Image(systemName: "phone")
                            .foregroundColor(Color.primaryColorLegacy)
                        
                        Button(animal.phone!, action: {
                            let filteredPhone = animal.phone!.filter("0123456789".contains)
                            if let phoneUrl = URL(string: "tel:\(filteredPhone)") {
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(phoneUrl)
                                } else {
                                    UIApplication.shared.openURL(phoneUrl)
                                }
                            }
                        })
                            .font(.subheadline)
                            .foregroundColor(Color.primaryColorLegacy)
                    }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
                
                if (animal.email != nil) {
                    Divider()
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(Color.primaryColorLegacy)
                        
                        Button(animal.email!, action: {
                            if let emailUrl = URL(string: "mailto:\(animal.email!)") {
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(emailUrl)
                                } else {
                                    UIApplication.shared.openURL(emailUrl)
                                }
                            }
                        })
                            .font(.subheadline)
                            .foregroundColor(Color.primaryColorLegacy)
                    }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
                
                if (animal.showAddress()) {
                    Divider()
                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(Color.primaryColorLegacy)
                        
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
                            .font(.subheadline)
                            .foregroundColor(Color.primaryColorLegacy)
                    }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
                
                Divider()
                HStack {
                    Image(systemName: viewModel.favoriteButtonIcon)
                        .foregroundColor(Color.primaryColorLegacy)
                    
                    Button(viewModel.favoriteButtonLabel, action: {
                        viewModel.addOrRemoveFromFavorites(animal: animal)
                    })
                        .font(.subheadline)
                        .foregroundColor(Color.primaryColorLegacy)
                        .onAppear(perform: { viewModel.initializeFavoriteButton(animal: animal) })
                }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            
                Spacer()
            }.navigationBarTitle(animal.name)
        }.primaryNavigationColor
    }
}
