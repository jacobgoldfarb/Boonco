//
//  SceneDelegate.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-25.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit
import CoreLocation

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let center = UNUserNotificationCenter.current()
    let locationManager = CLLocationManager()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupAuthState()
        setupWindow(scene: windowScene)
        setupLocationManager()
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    private func setupWindow(scene: UIWindowScene) {
        window = UIWindow(frame: UIScreen.main.bounds)
        AppDelegate.standard.window = window
        UINavigationBar.appearance().titleTextAttributes = Theme.standard.navBarStyle
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = Theme.standard.colors.primary
        window?.rootViewController = Theme.standard.getKeyController()
        window?.makeKeyAndVisible()
        window?.windowScene = scene
    }
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringVisits()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
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

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

@available(iOS 13.0, *)
extension SceneDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        let _ = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        LocationManager.shared.lastLocation = locations.last
    }
}
