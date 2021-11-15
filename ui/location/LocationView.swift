//
//  LocationView.swift
//  Adoptable
//
//  Created by Rowan Hall on 10/18/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import SwiftUI
import CoreLocation

struct LocationView: View {
    
    @State private var zipCode: String = ""
    @State private var searchAction: Int? = 0

    var body: some View {
        VStack {
            Form {
                Section {
                    Text("If you don't want to grant Adoptable your location, you can enter your zipcode instead")
                    TextField("Zip Code", text: $zipCode)
                        .keyboardType(.decimalPad)
                    
                    NavigationLink(destination: AppView(location: zipCode), tag: 1, selection: $searchAction) {
                        Button("Enter", action: { self.searchAction = 1})
                            .foregroundColor(Color.primaryColorLegacy)
                            .disabled(zipCode.isEmpty)
                    }
                    .disabled(zipCode.isEmpty)
                }
            }
        }
        .primaryNavigationColor
        .navigationTitle("Manual Location")
        .navigationBarBackButtonHidden(true)
    }
}

extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }
    
    var longitude: Double {
        return self.coordinate.longitude
    }
}
