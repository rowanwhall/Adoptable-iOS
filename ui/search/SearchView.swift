//
//  SearchView.swift
//  Adoptable
//
//  Created by Rowan Hall on 2/25/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import SwiftUI

struct SearchView : View {
    
    @ObservedObject private var viewModel = SearchViewModel()
    
    @State private var searchAction: Int? = 0
    @State private var zipCode: String = ""
    @State private var selectedType = 0
    @State private var selectedSize = 0
    @State private var selectedAge = 0
    @State private var selectedSex = 0
    @State private var selectedBreed = 0
    
    private let animalTypes = ["Any Animal", "Dogs", "Cats", "Birds", "Reptiles", "Small Furry", "Horses", "Rabbits", "Barnyard"]
    private let sizes = ["Any", "S", "M", "L", "XL"]
    private let ages = ["Any", "Baby", "Young", "Adult", "Senior"]
    private let sexes = ["Any", "Male", "Female"]
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Zip Code", text: $zipCode)
                        .keyboardType(.decimalPad)
                    
                    Picker(selection: $selectedType, label: Text("Animal Type")) {
                                ForEach(0 ..< animalTypes.count) {
                                   Text(self.animalTypes[$0])
                                }
                    }
                    .onChange(of: self.selectedType) { newValue in
                        viewModel.getBreeds(type: SearchArgumentMapper.animalTypeFromIndex(index: newValue))
                    }.pickerStyle(.menu)
                    
                    if (selectedType > 0) {
                        Picker(selection: $selectedBreed, label: Text("Breed")) {
                           ForEach(0 ..< (viewModel.resource.resourceData ?? [SearchViewModel.DEFAULT_BREED_SELECTION]).count, id: \.self) {
                               Text((viewModel.resource.resourceData ?? [SearchViewModel.DEFAULT_BREED_SELECTION])[$0].name)
                           }
                        }.pickerStyle(.menu)
                    }

                    Picker(selection: $selectedSize, label: Text("Size")) {
                        ForEach(0 ..< sizes.count) {
                           Text(self.sizes[$0])
                        }
                     }.pickerStyle(.segmented)

                    Picker(selection: $selectedAge, label: Text("Age")) {
                        ForEach(0 ..< ages.count) {
                           Text(self.ages[$0])
                        }
                     }.pickerStyle(.segmented)

                    Picker(selection: $selectedSex, label: Text("Sex")) {
                        ForEach(0 ..< sexes.count) {
                           Text(self.sexes[$0])
                        }
                     }.pickerStyle(.segmented)
                    
                    NavigationLink(destination: AnimalListView(
                                    arguments: NearbyAnimalArguments(location: zipCode,
                                                                     animal: SearchArgumentMapper.animalTypeFromIndex(index: selectedType),
                                                                     size: SearchArgumentMapper.sizeFromIndex(index: selectedSize),
                                                                     age: SearchArgumentMapper.ageFromIndex(index: selectedAge),
                                                                     sex: SearchArgumentMapper.sexFromIndex(index: selectedSex),
                                                                     breed: viewModel.getBreedParamForIndex(index: selectedBreed)),
                                    customTitle: "Search Results"), tag: 1, selection: $searchAction) {
                        Button("Search", action: { self.searchAction = 1})
                            .disabled(zipCode.isEmpty)
                    }
                    .disabled(zipCode.isEmpty)
                }
            }
        }
        .primaryNavigationColor
    }
}
