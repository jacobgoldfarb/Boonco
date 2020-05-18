//
//  SignUpViewModel.swift
//  Boonco
//
//  Created by Jacob Goldfarb on 2020-04-30.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import CoreLocation

protocol SignUpViewModelDelegate {
    func signUpDidSucceed()
    func signUpDidFail(withError error: Error)
    func didUpdateAddress(_ address: String)
}


class SignUpViewModel {
    
    var signUpDelegate: SignUpViewModelDelegate!
    let authService: AuthenticationServiceable
    var signUpCredentials: SignUpCredentials = SignUpCredentials()
    
    init(authService: AuthenticationServiceable) {
        self.authService = authService
    }
    
    func signUp() {
        let coordinate = CLLocationCoordinate2D(latitude: signUpCredentials.latitude, longitude: signUpCredentials.longitude)
        guard !signUpCredentials.firstName.isEmpty, !signUpCredentials.lastName.isEmpty else {
            signUpDelegate.signUpDidFail(withError: LRError.missingNames)
            return
        }
        guard !signUpCredentials.location.isEmpty else {
            signUpDelegate.signUpDidFail(withError: LRError.missingLocation)
            return
        }
        guard CoreLocation.CLLocationCoordinate2DIsValid(coordinate) == true else {
            signUpDelegate.signUpDidFail(withError: LRError.invalidLocation)
            return
        }
        guard !signUpCredentials.email.isEmpty, !signUpCredentials.password.isEmpty else {
            signUpDelegate.signUpDidFail(withError: LRError.missingEmailOrPassword)
            return
        }
        guard signUpCredentials.password == signUpCredentials.confirmPassword else {
            signUpDelegate.signUpDidFail(withError: LRError.passwordsDoNotMatch)
            return
        }
        if let error = getEmailError(signUpCredentials.email) {
            signUpDelegate.signUpDidFail(withError: error)
            return
        }
        else if let error = getPasswordError(signUpCredentials.password) {
            signUpDelegate.signUpDidFail(withError: error)
            return
        }
        authService.signUp(withCreds: signUpCredentials) { (error, user) in
            if let signUpError = error {
                self.signUpDelegate.signUpDidFail(withError: signUpError)
                return
            }
            self.signUpDelegate.signUpDidSucceed()
        }
    }
    
    // MARK: Location
    
    func generateUserLocation(from address: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
                let currentPlacemark = placemarks.last,
                let location = currentPlacemark.location else {
                    return
            }
            self.updateCoordinateFields(with: location)
            self.updateLocationFields(with: currentPlacemark)
            
            LocationManager.shared.lastLocation = location
        }
    }
        
    func syncAndUpdateAddress(from location: CLLocation) {
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil else {
                self.signUpDelegate.signUpDidFail(withError: LRError.invalidLocation)
                return
            }
            if let placemarks = placemarks {
                let convertedAddress = self.convertPlacemarkToText(placemarks.last)
                self.signUpDelegate.didUpdateAddress(convertedAddress)
                self.updateCoordinateFields(with: location)
                if let currentPlacemark = placemarks.last {
                    self.updateLocationFields(with: currentPlacemark)
                }
            }
        }
    }
    
    private func convertPlacemarkToText(_ placemark: CLPlacemark?) -> String {
        var addressString : String = ""
        
        if let currentPlacemark = placemark {
            
            // Street number
            if let subThoroughfare = currentPlacemark.subThoroughfare {
                addressString += subThoroughfare + " "
            }
            
            // Street
            if let thoroughfare = currentPlacemark.thoroughfare {
                addressString += thoroughfare + ", "
            }
            
            // City, town, village, etc
            if let locality = currentPlacemark.locality {
                addressString += locality + ", "
            }
            
            // Country
            if let country = currentPlacemark.country {
                addressString += country
            }
            
            // Postal code
            if let postal = currentPlacemark.postalCode {
                addressString += ", " + postal
            }
        }
        return addressString
    }
    
    
    private func updateCoordinateFields(with location: CLLocation) {
        signUpCredentials.latitude = location.coordinate.latitude
        signUpCredentials.longitude = location.coordinate.longitude
    }
    
    private func updateLocationFields(with placemark: CLPlacemark) {
        signUpCredentials.street = placemark.thoroughfare ?? ""
        signUpCredentials.city = placemark.locality ?? ""
        signUpCredentials.subNation = placemark.administrativeArea ?? ""
        signUpCredentials.country = placemark.country ?? ""
    }
    
    // MARK: Validation
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func getEmailError(_ email: String) -> Error? {
        if !isValidEmail(email) {
            return LRError.invalidEmailFormat
        } else {
            return nil
        }
    }
    
    func getPasswordError(_ password: String) -> Error? {
        if password.count < 8 {
            return LRError.passwordTooShort
        } else {
            return nil
        }
    }
}
