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
    
    @ObservedObject var lm = LocationManager()
    @State private var zipCode: String = ""
    @State private var searchAction: Int? = 0

    var latitude: String  { return("\(lm.location?.latitude ?? 0)") }
    var longitude: String { return("\(lm.location?.longitude ?? 0)") }
    var placemark: String { return("\(lm.placemark?.description ?? "XXX")") }
    var status: String    { return("\(String(describing: lm.status))") }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Text("If you don't want to grant Adoptable your location, you can enter your zipcode instead")
                        TextField("Zip Code", text: $zipCode)
                            .keyboardType(.decimalPad)
                        
                        NavigationLink(destination: AppView(location: zipCode), tag: 1, selection: $searchAction) {
                            Button("Enter", action: { self.searchAction = 1}).disabled(zipCode.isEmpty)
                        }
                        .disabled(zipCode.isEmpty)
                    }
                }
                
                Text("Latitude: \(self.latitude)")
                Text("Longitude: \(self.longitude)")
                Text("Placemark: \(self.placemark)")
                Text("Status: \(self.status)")
            }
        }
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
