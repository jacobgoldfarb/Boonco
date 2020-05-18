//
//  AppDelegate.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-25.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit
import IQKeyboardManager
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let center = UNUserNotificationCenter.current()
    let locationManager = CLLocationManager()
    
    //TODO: remove later - related to SVProgressHUD centering bug in iOS13
    static var standard: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    fileprivate func setupNavigationAppearance() {
        UINavigationBar.appearance().titleTextAttributes = Theme.standard.navBarStyle
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = Theme.standard.colors.primary
        UINavigationBar.appearance().clipsToBounds = true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared().isEnabled = true
        setupNavigationAppearance()
        
        if #available(iOS 13.0, *) { return true }
        
        setupAuthState()
        setupWindow()
        setupLocationManager()
        return true
    }
    
    private func setupWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = Theme.standard.getKeyController()
        self.window?.makeKeyAndVisible()
    }
    
    private func setupLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startMonitoringVisits()
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
        }
    }
    
    private func setupAuthState() {
        do {
            try AuthState.shared.retrieveToken()
            Theme.standard.activeControllerType = .index
        } catch LRError.notAuthenticated {
            Theme.standard.activeControllerType = .welcome
        } catch {
            print("Unexpected error")
        }
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        let _ = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        LocationManager.shared.lastLocation = locations.last
    }
}
