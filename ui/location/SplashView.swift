//
//  SplashView.swift
//  Adoptable
//
//  Created by Rowan Hall on 8/23/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation

import SwiftUI
import CoreLocation

struct SplashView: View {
    
    enum NavigationDestination: String {
        case appView
        case locationView
    }
    
    @ObservedObject var lm = LocationManager()
    
    @State var selectedDestination: NavigationDestination?
    @State var latLng = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Splash Screen Here")
                NavigationLink(destination: AppView(location: self.latLng), tag: .appView, selection: $selectedDestination) {}
                NavigationLink(destination: LocationView(), tag: .locationView, selection: $selectedDestination) {}
            }
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea([.top, .bottom])
        .onAppear(perform: subscribeToLocationUpdates)
    }
    
    private func subscribeToLocationUpdates() {
        if (lm.isLocationDenied()) {
            self.selectedDestination = .locationView
            return
        }
        lm.requestUpdates { (status: CLAuthorizationStatus) in
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                self.lm.startUpdatingLocation()
            } else {
                self.selectedDestination = .locationView
                return
            }
        } onLocationUpdate: { (location: CLLocation) in
            // Avoid multiple navigation calls
            if self.latLng.count > 0 {
                return
            }
            self.latLng = String(location.latitude) + "," + String(location.longitude)
            self.selectedDestination = .appView
        }
    }
    
}