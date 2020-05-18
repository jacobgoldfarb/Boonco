//
//  LocationManager.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-10.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager {
    
    static var shared: LocationManager = LocationManager()
    var lastLocation: CLLocation? {
        get {
            if self._lastLocation == nil {
                let lat = UserDefaults.standard.double(forKey: "lat")
                let long = UserDefaults.standard.double(forKey: "long")
                guard lat + long != 0 else { return nil }
                _lastLocation = CLLocation(latitude: lat, longitude: long)
                return _lastLocation
            } else {
                return _lastLocation
            }
        }
        set(newValue) {
            guard let location = newValue else { return }
            setCity(forLocation: location)
            UserDefaults.standard.set(location.coordinate.latitude, forKey: "lat")
            UserDefaults.standard.set(location.coordinate.longitude, forKey: "long")
            _lastLocation = location
        }
    }
    
    var city: String? = nil
    private var _secondLastLocation: CLLocation? = nil
    private var _lastLocation: CLLocation? = nil {
        didSet {
            _secondLastLocation = oldValue
        }
    }
    
    private func setCity(forLocation location: CLLocation) {
        guard let location = _lastLocation else { return }
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { placemarks, _ in
            placemarks?.forEach { (placemark) in
                if let city = placemark.locality {
                    self.city = city
                }
            }
        }
    }
}
