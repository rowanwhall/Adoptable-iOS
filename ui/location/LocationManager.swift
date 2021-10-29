//
//  LocationManager.swift
//  Adoptable
//
//  Created by Rowan Hall on 10/18/20.
//  Copyright © 2020 Rowan Hall. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    
    private var onStatusUpdate: ((CLAuthorizationStatus) -> Void)?
    private var onLocationUpdate: ((CLLocation) -> Void)?
    
    func requestUpdates(onStatusUpdate:@escaping (CLAuthorizationStatus) -> Void, onLocationUpdate: ((CLLocation) -> Void)?) {
        self.onStatusUpdate = onStatusUpdate
        self.onLocationUpdate = onLocationUpdate
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    func isLocationDenied() -> Bool {
        return self.locationManager.authorizationStatus == CLAuthorizationStatus.denied
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.onStatusUpdate?(status)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.onLocationUpdate?(location)
    }
}
